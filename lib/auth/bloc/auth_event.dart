import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();
}

@immutable
class SignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class SignOutAuthEvent extends AuthEvent {
  const SignOutAuthEvent();
}

@immutable
class RegisterAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterAuthEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class GoToSignInViewEvent extends AuthEvent {
  const GoToSignInViewEvent();
}

@immutable
class GoToRegisterViewEvent extends AuthEvent {
  const GoToRegisterViewEvent();
}

@immutable
class AppEventDeleteAccount extends AuthEvent {
  const AppEventDeleteAccount();
}
