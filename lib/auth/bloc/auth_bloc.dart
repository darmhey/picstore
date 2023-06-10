import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/auth_event.dart';
import 'package:picstore/auth/bloc/auth_state.dart';
import 'package:picstore/auth/errors/auth_errors.dart';

import '../../utils/upload_image.dart';

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
        emit(const SignedOutAuthState(isLoading: false));
      }),
    );
    on<SignInAuthEvent>(
      (event, emit) async {
        //start loading
        emit(
          const SignedOutAuthState(
            isLoading: true,
          ),
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
          final images = await _getImages(user.uid);
          emit(
            SignedInAuthState(
              isLoading: false,
              user: user,
              images: images,
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
      },
    );

    on<SignOutAuthEvent>((event, emit) async {
      // start loading
      emit(
        const SignedOutAuthState(
          isLoading: true,
        ),
      );
      // log the user out
      await FirebaseAuth.instance.signOut();
      //stop loading
      emit(
        const SignedOutAuthState(
          isLoading: false,
        ),
      );
    });

    on<RegisterAuthEvent>((event, emit) async {
      //start loading
      emit(
        const RegistrationViewState(isLoading: true),
      );
      //
      try {
        final email = event.email;
        final password = event.password;
        // create the user
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //if successful, sign in user
        emit(
          SignedInAuthState(
            user: credentials.user!,
            isLoading: false,
            images: const [],
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(
          RegistrationViewState(
            isLoading: false,
            authError: AuthError.from(e),
          ),
        );
      }
    });
    on<InitializeAuthEvent>((event, emit) async {
      //get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(
          const SignedOutAuthState(isLoading: false),
        );
      } else {
        // go grab the user's uploaded images
        final images = await _getImages(user.uid);
        emit(
          SignedInAuthState(
            user: user,
            isLoading: false,
            images: images,
          ),
        );
      }
    });

    // handle account deletion
    on<AppEventDeleteAccount>(
      (event, emit) async {
        //grab user 2
        final user = FirebaseAuth.instance.currentUser;
        // log the user out if we don't have a current user
        if (user == null) {
          emit(
            const SignedOutAuthState(
              isLoading: false,
            ),
          );
          return;
        }
        // start loading
        emit(
          SignedInAuthState(
            isLoading: true,
            user: user,
            images: state.images ?? [],
          ),
        );
        // delete the user folder
        try {
          // delete user folder content
          final folderContents =
              await FirebaseStorage.instance.ref(user.uid).listAll();
          for (final item in folderContents.items) {
            await item.delete().catchError((_) {}); // maybe handle the error?
          }
          // delete the folder itself
          await FirebaseStorage.instance
              .ref(user.uid)
              .delete()
              .catchError((_) {});

          // delete the user
          await user.delete();
          // log the user out
          await FirebaseAuth.instance.signOut();
          // log the user out in the UI as well
          emit(
            const SignedOutAuthState(
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            SignedInAuthState(
              isLoading: false,
              user: user,
              images: state.images ?? [],
              authError: AuthError.from(e),
            ),
          );
        } on FirebaseException {
          // we might not be able to delete the folder
          // log the user out
          emit(
            const SignedOutAuthState(
              isLoading: false,
            ),
          );
        }
      },
    );

    // handle uploading images
    on<AppEventUploadImage>(
      (event, emit) async {
        //grab user 1
        //grab the user using the getter extension method
        //we defined on AuthState
        final user = state.user;
        // log user out if we don't have an actual user in app state
        if (user == null) {
          emit(
            const SignedOutAuthState(
              isLoading: false,
            ),
          );
          return;
        }
        // start the loading process
        emit(
          SignedInAuthState(
            isLoading: true,
            user: user,
            images: state.images ?? [],
          ),
        );
        // upload the file
        final file = File(event.filePathToUpload);
        await uploadImage(
          file: file,
          userId: user.uid,
        );
        // after upload is complete, grab the latest file references
        final images = await _getImages(user.uid);
        // emit the new images and turn off loading
        emit(
          SignedInAuthState(
            isLoading: false,
            user: user,
            images: images,
          ),
        );
      },
    );
  }

  Future<Iterable<Reference>> _getImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
