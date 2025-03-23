// ignore_for_file: use_build_context_synchronously

import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:cipherschool_assignment/custom_widgets/custom_button.dart';
import 'package:cipherschool_assignment/custom_widgets/custom_textfield.dart';
import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isTermsAccepted = false;
  bool isLoading = false;

  // Firebase Sign Up
  Future<void> _signUpWithEmailPassword() async {
    if (_formKey.currentState!.validate() && isTermsAccepted) {
      setState(() => isLoading = true);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful!')),
        );
        context.go(AppRouter.homeRoute);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Sign up failed')),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed in with Google!'),
        ),
      );
      context.go(AppRouter.homeRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              "assets/images/arrow_left.svg",
              width: 2.w,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60.h),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  enabled: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Name";
                    }
                    if (val.length < 3) {
                      return "Name must be at least 3 characters long";
                    }
                    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val)) {
                      return "Name can only contain alphabets";
                    }
                    return null;
                  },
                  labelText: "Name",
                  hintFontSize: 16.sp,
                  obscureText: false,
                  fontSize: 16.sp,
                  maxlines: 1,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                SizedBox(height: 16.h),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Email";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(val)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  labelText: "Email",
                  hintFontSize: 16.sp,
                  obscureText: false,
                  fontSize: 16.sp,
                  maxlines: 1,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                SizedBox(height: 16.h),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Password";
                    }
                    if (val.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(val)) {
                      return "Password must contain at least 1 uppercase letter";
                    }
                    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(val)) {
                      return "Password must contain at least 1 number";
                    }
                    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(val)) {
                      return "Password must contain at least 1 special character";
                    }
                    return null;
                  },
                  labelText: "Password",
                  hintFontSize: 16.sp,
                  obscureText: !isPasswordVisible,
                  fontSize: 16.sp,
                  maxlines: 1,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(
                          () {
                            isTermsAccepted = value!;
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you agree to the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of Service and Privacy Policy',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    context.go(AppRouter.homeRoute);
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  'Or with',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : _signUpWithGoogle,
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 24.h,
                    ),
                    label: Text(
                      'Sign Up with Google',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      side: BorderSide(
                        width: 3.w,
                        color: const Color(
                          0xffF1F1FA,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account ?',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: '  Login',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline,
                        ),
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
