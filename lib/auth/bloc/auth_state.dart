import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:picstore/auth/errors/auth_errors.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    this.authError,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [authError];
}

class SignedInAuthState extends AuthState {
  final User user;
  //final Iterable<Reference?> images;

  const SignedInAuthState({
    required this.user,
    //required this.images,
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  // @override
  // String toString() => 'SignedInAuthState;
  //images.length = ${images.length}';
}

class SignedOutAuthState extends AuthState {
  const SignedOutAuthState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  @override
  String toString() =>
      'SignedOutAuthState, isLoading = $isLoading, authError = $authError';
}

class RegistrationViewState extends AuthState {
  const RegistrationViewState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class SignInViewState extends AuthState {
  const SignInViewState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}
