import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/auth_event.dart';
import 'package:picstore/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const SignedOutAuthState(isLoading: false),
        ) {
    on<GoToRegisterViewEvent>(((event, emit) {
      emit(
        const RegistrationViewState(
          isLoading: false,
        ),
      );
    }));
  }
}
