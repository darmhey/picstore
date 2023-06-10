import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
class InitializeAuthEvent implements AuthEvent {
  const InitializeAuthEvent();
}

@immutable
class SignInAuthEvent implements AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class SignOutAuthEvent implements AuthEvent {
  const SignOutAuthEvent();
}

@immutable
class RegisterAuthEvent implements AuthEvent {
  final String email;
  final String password;

  const RegisterAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class GoToSignInViewEvent implements AuthEvent {
  const GoToSignInViewEvent();
}

@immutable
class GoToRegisterViewEvent implements AuthEvent {
  const GoToRegisterViewEvent();
}

@immutable
class AppEventDeleteAccount implements AuthEvent {
  const AppEventDeleteAccount();
}

@immutable
class AppEventUploadImage implements AuthEvent {
  final String filePathToUpload;

  const AppEventUploadImage({
    required this.filePathToUpload,
  });
}
