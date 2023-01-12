import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class InitializeEvent extends AuthEvent {
  const InitializeEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterEvent({
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
