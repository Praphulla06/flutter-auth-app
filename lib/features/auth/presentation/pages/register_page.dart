import 'package:auth_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_app/features/auth/presentation/widgets/my_button.dart';
import 'package:auth_app/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Password do not match")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill up all fields")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevent UI shift when keyboard comes up
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
                    "Let's create an account for you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // Form fields
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      MyTextField(
                          controller: nameController,
                          hintText: "Name: ",
                          obscureText: false),
                      const SizedBox(height: 25),
                      MyTextField(
                          controller: emailController,
                          hintText: "Email: ",
                          obscureText: false),
                      const SizedBox(height: 25),
                      MyTextField(
                          controller: passwordController,
                          hintText: "Password: ",
                          obscureText: true),
                      const SizedBox(height: 25),
                      MyTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password: ",
                          obscureText: true),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
                // Button and Log In link
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      MyButton(onTap: register, text: "Create an account"),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text("Already a member?"),
                          GestureDetector(
                              onTap: widget.togglePage,
                              child: Text("Log In",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))
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
