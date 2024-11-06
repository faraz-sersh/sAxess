import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skey/utils/color_utils.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.child,
    required this.onTap,
  });

  final double height;
  final double width;
  final Color color;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: ColorUtils.primaryColor.withOpacity(0.5),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r))),
        child: child,
      ),
    );
  }
}
