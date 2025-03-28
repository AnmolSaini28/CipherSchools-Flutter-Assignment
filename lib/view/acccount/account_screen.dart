// ignore_for_file: use_build_context_synchronously

import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:cipherschool_assignment/navigation/custome_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        setState(
          () {
            userName = userDoc['name'] ?? 'User';
          },
        );
      }
    } catch (e) {
      debugPrint('Error fetching username: ${e.toString()}');
      setState(
        () {
          userName = 'User';
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 4;

    final List<String> routes = [
      '/home',
      '',
      '/dialog',
      '',
      '/profile',
    ];

    void onItemTapped(int index) {
      if (index == 1 || index == 3) {
        return;
      }
      context.go(routes[index]);
      setState(
        () {
          selectedIndex = index;
        },
      );
    }

    Future<void> clearHiveData() async {
      try {
        await Hive.deleteFromDisk();
        await Hive.close();
      } catch (e) {
        debugPrint("Error clearing Hive data: ${e.toString()}");
      }
    }

    Future<void> logout() async {
      await FirebaseAuth.instance.signOut();

      await clearHiveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout successful!')),
      );
      context.go(AppRouter.signUpRoute);
    }

    return Scaffold(
      backgroundColor: const Color(0xffF9F9FB),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const AssetImage(
                          'assets/images/image.png',
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/images/edit.svg',
                          height: 24.h,
                          width: 24.w,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: _buildOption(
                        icon: 'assets/images/account.svg',
                        label: 'Account',
                        color: const Color(0xffEEE5FF),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: _buildOption(
                        icon: 'assets/images/settings.svg',
                        label: 'Settings',
                        color: const Color(0xffEEE5FF),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: _buildOption(
                        icon: 'assets/images/export.svg',
                        label: 'Export Data',
                        color: const Color(0xffEEE5FF),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: InkWell(
                        onTap: () async {
                          logout();
                        },
                        child: _buildOption(
                          icon: 'assets/images/logout.svg',
                          label: 'Logout',
                          color: const Color(0xffFFE2E4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          height: 52.h,
          width: 52.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
