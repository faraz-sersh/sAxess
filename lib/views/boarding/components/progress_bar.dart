import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/color_utils.dart';

class BoardingProgressWidget extends StatelessWidget {
  const BoardingProgressWidget({
    super.key, required this.progress,
  });
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 5.h,
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(
        color: ColorUtils.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Container(
        width: (350*(progress/100)).w,
        height: 5.h,
        decoration: ShapeDecoration(
          color: ColorUtils.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}