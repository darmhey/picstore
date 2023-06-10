import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:picstore/auth/errors/auth_errors.dart';

@immutable
class AuthState extends Equatable {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    this.authError,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [authError, isLoading];
}

@immutable
class SignedInAuthState extends AuthState {
  final User user;
  final Iterable<Reference> images;

  const SignedInAuthState({
    required this.user,
    required this.images,
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is SignedInAuthState) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );

  @override
  String toString() => 'AppStateLoggedIn, images.length = ${images.length}';
}

@immutable
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

@immutable
class RegistrationViewState extends AuthState {
  const RegistrationViewState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

//idamu adugbo?
// @immutable
// class SignInViewState extends AuthState {
//   const SignInViewState({
//     required bool isLoading,
//     AuthError? authError,
//   }) : super(
//           isLoading: isLoading,
//           authError: authError,
//         );
// }

extension GetUser on AuthState {
  User? get user {
    final cls = this;
    if (cls is SignedInAuthState) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AuthState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is SignedInAuthState) {
      return cls.images;
    } else {
      return null;
    }
  }
}
