// ignore_for_file: use_build_context_synchronously

import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            bool isSignedIn = await _checkIfUserIsSignedIn();

            if (isSignedIn) {
              context.go(AppRouter.homeRoute);
            } else {
              context.go(AppRouter.signUpRoute);
            }
          },
          child: Image.asset(
            'assets/images/onboarding.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<bool> _checkIfUserIsSignedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
