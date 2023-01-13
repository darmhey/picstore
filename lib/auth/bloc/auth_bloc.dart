import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/auth_event.dart';
import 'package:picstore/auth/bloc/auth_state.dart';
import 'package:picstore/auth/errors/auth_errors.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const SignedOutAuthState(isLoading: false),
        ) {
    on<GoToRegisterViewEvent>(
      ((event, emit) {
        emit(
          const RegistrationViewState(isLoading: false),
        );
      }),
    );
    on<GoToSignInViewEvent>(
      ((event, emit) {
        emit(const SignInViewState(isLoading: false));
      }),
    );
    on<SignInAuthEvent>(
      ((event, emit) async {
        //start loading
        emit(
          const SignedOutAuthState(isLoading: true),
        );
        try {
          //try to get user instance with email and password
          final email = event.email;
          final password = event.password;
          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          //if successful, sign user in the app
          final user = userCredential.user!;

          emit(
            SignedInAuthState(
              isLoading: false,
              user: user,
            ),
          );
          /*
          on exception, sign user out (display login view, 
          should we emit loginview) or we define in the UI that
           when state is logged out display sign in view?
          Is both okay?
          */

        } on FirebaseAuthException catch (e) {
          emit(
            SignedOutAuthState(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      }),
    );

    on<SignOutAuthEvent>((event, emit) async {
      //signout

      await FirebaseAuth.instance.signOut();
      //stop loading
      emit(
        const SignInViewState(isLoading: false),
      );
    });

    on<RegisterAuthEvent>((event, emit) async {
      //start loading
      emit(const RegistrationViewState(isLoading: true));
      //
      try {
        //try to create user
        final email = event.email;
        final password = event.password;
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //if successful, sign in user
        emit(
          SignedInAuthState(user: credentials.user!, isLoading: false),
        );
      } on FirebaseAuthException catch (e) {
        emit(RegistrationViewState(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });
    on<InitializeAuthEvent>((event, emit) async {
      //get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const SignedOutAuthState(isLoading: false));
      } else {
        emit(SignedInAuthState(user: user, isLoading: false));
      }
    });
  }
}
