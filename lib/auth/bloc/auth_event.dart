import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();
}

class SignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

class SignOutAuthEvent extends AuthEvent {
  const SignOutAuthEvent();
}

class RegisterAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterAuthEvent({
    required this.email,
    required this.password,
  });
}

class GoToSignInViewEvent extends AuthEvent {
  const GoToSignInViewEvent();
}

class GoToRegisterViewEvent extends AuthEvent {
  const GoToRegisterViewEvent();
}
