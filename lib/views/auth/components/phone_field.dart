import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../utils/color_utils.dart';

class MyPhoneField extends StatelessWidget {
  MyPhoneField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  final borderStyle = OutlineInputBorder(
      gapPadding: 12,
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: ColorUtils.textBlack));

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      dropdownTextStyle: TextStyle(
          fontFamily: "Outfit", fontSize: 16.sp
      ),
      style: TextStyle(fontFamily: "Outfit", fontSize: 16.sp),
      cursorColor: ColorUtils.textBlack,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
          enabledBorder: borderStyle,
          disabledBorder: borderStyle,
          border: borderStyle,
          focusedBorder: borderStyle,
          hintText: "Phone Number",
          hintStyle: TextStyle(fontFamily: "Outfit", fontSize: 16.sp)),
      initialCountryCode: 'FR',
      onChanged: (phone) {
        //print(phone.completeNumber);
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (v) {
        if (v!.number.isEmpty) {
          return "Please fill in this field";
        } else if (v!.completeNumber.isEmpty) {
          return "Please enter complete number";
        }
      },
    );
  }
}
