import 'package:auth_app/features/auth/presentation/pages/login_page.dart';
import 'package:auth_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogInPage = true;
  void togglePage () {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showLogInPage ? LoginPage(togglePage: togglePage) : RegisterPage(togglePage: togglePage,);
  }
}