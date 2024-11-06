import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';

class TextUtils {
  static Text txt(
      {required String text,
        Color color =  ColorUtils.textBlack,
        TextAlign? textAlign,
        double fontSize = 14 ,
        FontWeight fontWeight = FontWeight.w400,
        String? fontFamily,
        int? maxLines,
        TextDecoration decoration = TextDecoration.none,
        TextOverflow? overflow}) {
    return Text(
      text.tr,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          fontFamily: "Outfit",
          decoration: decoration,
          decorationColor: ColorUtils.textBlack
      ),
    );
  }
}