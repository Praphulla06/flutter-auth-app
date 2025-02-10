import 'package:auth_app/features/auth/data/repositories/firebase_app_user_repo.dart';
import 'package:auth_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:auth_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:auth_app/features/auth/presentation/pages/auth_page.dart';
import 'package:auth_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAppUserRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return AuthPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, authState) {
            if (authState is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(authState.message)));
            }
          },
        ),
      ),
    );
  }
}
