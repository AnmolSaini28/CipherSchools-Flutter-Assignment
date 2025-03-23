// ignore_for_file: use_build_context_synchronously

import 'package:cipherschool_assignment/constants/app_constants.dart';
import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:cipherschool_assignment/custom_widgets/custom_button.dart';
import 'package:cipherschool_assignment/custom_widgets/custom_dropdown.dart';
import 'package:cipherschool_assignment/custom_widgets/custom_textfield.dart';
import 'package:cipherschool_assignment/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String? selectedCategory;
  String? selectedWallet;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> _saveExpenseData() async {
    if (amountController.text.isEmpty ||
        selectedCategory == null ||
        descriptionController.text.isEmpty ||
        selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields!')),
      );
      return;
    }

    final DateTime now = DateTime.now();

    final String formattedTime = DateFormat('hh:mm a').format(now);

    final expenseData = {
      'amount': double.parse(amountController.text),
      'category': selectedCategory,
      'description': descriptionController.text,
      'wallet': selectedWallet,
      'timestamp': formattedTime,
    };

    var box = Hive.box('expenseBox');
    await box.add(expenseData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added successfully!')),
    );

    amountController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0077FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () => context.go(AppRouter.homeRoute),
            child: SvgPicture.asset(
              "assets/images/arrow_left.svg",
              width: 2.w,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          'Expense',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'How much?',
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xffFCFCFC).withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 64.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.currency_rupee,
                  size: 60.sp,
                  color: Colors.white,
                ),
                hintText: '0',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  children: [
                    CustomExpandableDropdown(
                      hintText: "Category",
                      items: AppConstants.categories,
                      selectedValue: selectedCategory,
                      onItemSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextfield(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      enabled: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Description";
                        }
                        return null;
                      },
                      labelText: "Description",
                      hintFontSize: 16.sp,
                      obscureText: false,
                      fontSize: 16.sp,
                      maxlines: 1,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    SizedBox(height: 16.h),
                    CustomExpandableDropdown(
                      hintText: "Wallet",
                      items: AppConstants.wallets,
                      selectedValue: selectedWallet,
                      onItemSelected: (value) {
                        setState(
                          () {
                            selectedWallet = value;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 135.h),
                    Container(
                      height: 2.h,
                      color: primaryColor,
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Continue',
                      onPressed: _saveExpenseData, // ✅ Save Data
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
