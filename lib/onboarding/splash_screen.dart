// ignore_for_file: use_build_context_synchronously

import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        if (!mounted) return;
        bool isSignedIn = await _checkIfUserIsSignedIn();
        if (mounted) {
          context.go(
            isSignedIn ? AppRouter.homeRoute : AppRouter.signUpRoute,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<bool> _checkIfUserIsSignedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
