import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstore/auth/bloc/bloc.dart';
import 'package:picstore/components/my_button.dart';
import 'package:picstore/components/my_textfield.dart';
import 'package:picstore/utils/if_debugging.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: LayoutBuilder(
        builder: ((context, constraints) {
          final width = constraints.maxWidth * 0.8;
          final height = constraints.maxHeight * 0.7;

          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: height,
                  maxWidth: width,
                ),
                child: const RegisterForm(),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController(
    text: 'johnasco19@gmail.com'.ifDebugging,
  );
  final passwordController = TextEditingController(
    text: 'dammy1111'.ifDebugging,
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 80,
        ),
        Text(
          'Sign up!',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(
                      const GoToSignInViewEvent(),
                    );
              },
              child: Text(
                'Already a member? Sign In',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        MyButton(
          onTap: (() {
            final email = emailController.text;
            final password = passwordController.text;
            context.read<AuthBloc>().add(
                  RegisterAuthEvent(
                    email: email,
                    password: password,
                  ),
                );
          }),
          buttonText: 'Register',
        )
      ],
    );
  }
}
