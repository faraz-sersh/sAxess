import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_utils.dart';

class MyFormField extends StatelessWidget {
  MyFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.emailValid = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final bool emailValid;
  final VoidCallback? onTap;

  final borderStyle = OutlineInputBorder(
      gapPadding: 12,
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: ColorUtils.textBlack));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType:
          emailValid ? TextInputType.emailAddress : TextInputType.text,
      onTap: onTap,
      validator: (v) {
        if (v!.trim().isEmpty) {
          return "Please fill in this field";
        }
        if (emailValid) {
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(v)) {
            return 'Please enter a valid email address';
          }
        }
        return null;
      },
      style: TextStyle(fontFamily: "Outfit", fontSize: 16.sp),
      cursorColor: ColorUtils.textBlack,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
          enabledBorder: borderStyle,
          disabledBorder: borderStyle,
          border: borderStyle,
          focusedBorder: borderStyle,
          hintText: hint,
          hintStyle: TextStyle(fontFamily: "Outfit", fontSize: 16.sp)),
    );
  }
}
