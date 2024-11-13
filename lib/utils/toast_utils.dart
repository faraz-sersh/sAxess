import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_utils.dart';

class ToastUtils {
  static void showToast(
      {required String message,
      Color backgroundColor = ColorUtils.grey,
      Color textColor = ColorUtils.textBlack}) {
    Fluttertoast.showToast(

        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0.sp);
  }
}
