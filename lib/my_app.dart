import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/bloc.dart';
import 'package:picstore/pages/gallery.dart';
import 'package:picstore/pages/register.dart';
import 'package:picstore/pages/sign_in.dart';
import 'package:picstore/utils/dialogs/auth_error_dialog.dart';
import 'package:picstore/utils/loading/loading_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(const InitializeAuthEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }

            final authError = authState.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
          builder: (context, authState) {
            if (authState is SignedOutAuthState) {
              return const SignIn();
            } else if (authState is SignedInAuthState) {
              return const Gallery();
            } else if (authState is RegistrationViewState) {
              return const Register();
            } else if (authState is SignInViewState) {
              return const SignIn();
            } else {
              // this should never happen
              return Container();
            }
          },
        ),
      ),
    );
  }
}
