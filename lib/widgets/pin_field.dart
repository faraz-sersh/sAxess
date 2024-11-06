
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:skey/utils/color_utils.dart';

class PinField extends StatelessWidget {
  const PinField({
    super.key,
    required this.controller,
    this.match
  });

  final TextEditingController controller;
  final String? match;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      //keyboardType: TextInputType.number,
      //hapticFeedbackType: HapticFeedbackType.heavyImpact,
      defaultPinTheme: PinTheme(
          height: 55.h,
          width: 55.w,
          decoration: BoxDecoration(
              color: ColorUtils.grey,
              borderRadius: BorderRadius.circular(10.r)),
          textStyle: const TextStyle(
              fontFamily: "Outfit",
              fontSize: 20,
              fontWeight: FontWeight.w600)),
      validator: (v) {
        if(match == null ) {
          if (v!.isEmpty || v.length < 6) {
            return "Please enter 6 digit pin";
          }
        }
        if(match !=  null){
          if (v!.isEmpty || v.length < 6) {
            return "Please enter 6 digit pin";
          }else if(v != match){
            // print(v);
            // print(match);
            return "Pin Mismatched";
          }

        }
      },
    );
  }
}
