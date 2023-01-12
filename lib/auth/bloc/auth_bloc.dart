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
        emit(
          const SignInViewState(isLoading: true),
        );
        try {
          final email = event.email;
          final password = event.password;
          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final user = userCredential.user!;
          emit(SignedInAuthState(
            isLoading: false,
            user: user,
          ));
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
      emit(
        const SignedOutAuthState(isLoading: true),
      );

      await FirebaseAuth.instance.signOut();
    });
    on<RegisterAuthEvent>((event, emit) async {
      emit(const RegistrationViewState(isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
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
