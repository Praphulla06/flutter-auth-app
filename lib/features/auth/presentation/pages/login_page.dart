import 'package:auth_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_app/features/auth/presentation/widgets/my_button.dart';
import 'package:auth_app/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authCubit = context.read<AuthCubit>();
    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter both email and password: ")));
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensures the UI doesn't shift when the keyboard appears
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Make the body scrollable when the keyboard shows
            child: Column(
              children: [
                // Icon at the top
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Icon(Icons.lock_open_rounded, size: 84),
                ),
                // Welcome Text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 50),
                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      MyTextField(
                        controller: emailController,
                        hintText: "Email: ",
                        obscureText: false,
                      ),
                      const SizedBox(height: 50),
                      MyTextField(
                        controller: passwordController,
                        hintText: "Password: ",
                        obscureText: true,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                // Button and Register link
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      MyButton(onTap: login, text: "Log In"),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text("Not a member?"),
                          GestureDetector(
                            onTap: widget.togglePage,
                            child: Text(
                              "Register Now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
