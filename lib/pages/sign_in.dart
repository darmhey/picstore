import 'package:flutter/material.dart';
import 'package:picstore/components/my_button.dart';
import 'package:picstore/components/my_textfield.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                child: const SignInForm(),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          'Welcome!',
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
              onTap: () {},
              child: Text(
                'Not a member? Register now',
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
          onTap: (() {}),
          buttonText: 'Sign In',
        )
      ],
    );
  }
}
