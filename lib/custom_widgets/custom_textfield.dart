import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final int? maxlines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double fontSize;
  final String? helperText;
  final FontWeight? fontWeight;
  final String? Function(String?)? validator;
  final double? lineSpacing;
  final double? hintFontSize;
  final FontWeight? hintFontWeight;
  final Color? hintTextColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  const CustomTextfield({
    super.key,
    this.onChanged,
    required this.enabled,
    this.controller,
    this.readOnly = false,
    this.maxlines,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.keyboardType,
    required this.fontSize,
    this.helperText,
    this.inputFormatters,
    this.fontWeight,
    this.validator,
    this.lineSpacing,
    this.hintFontSize,
    this.hintFontWeight,
    this.hintTextColor,
    this.onEditingComplete,
    this.floatingLabelBehavior,
    this.prefixText,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    String? labelWithAsterisk = widget.labelText;
    if (widget.validator != null) {
      labelWithAsterisk = '$labelWithAsterisk';
    }
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly!,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      minLines: 1,
      style: TextStyle(
        fontSize: 16.sp,
        height: 16.h / 15.h,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      enabled: widget.enabled,
      validator: widget.validator,
      cursorHeight: 15.sp,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      cursorColor: Colors.blue,
      maxLines: widget.maxlines,
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        fillColor: const Color(0xffFFFFFF),
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.0.h,
          horizontal: 16.0.w,
        ),
        helperText: widget.helperText,
        helperStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: textColor,
          fontSize: 16.sp,
        ),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        labelText: labelWithAsterisk,
        hintStyle: TextStyle(
            letterSpacing: widget.lineSpacing,
            color: widget.hintTextColor,
            fontSize: widget.hintFontSize,
            fontWeight: widget.hintFontWeight),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: textFieldColor, width: 3.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xff545456), width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xff545456), width: 1.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: textFieldColor, width: 3.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xff545456), width: 1.w),
        ),
      ),
    );
  }
}
