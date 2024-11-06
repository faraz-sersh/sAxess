
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

class WalletAddress extends StatelessWidget {
  const WalletAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width.w,
        height: 80.h,
        padding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            TextUtils.txt(
              text: 'Address :',
              color: ColorUtils.sBlack,
              fontSize: 18,
            ),
            Space.horizontal(16.w),
            Container(
              height: 30.h,
              width: 200.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorUtils.addressGreen.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.r)
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextUtils.txt(text: "0gdfvwkch.....5625", fontSize: 12),
                  Icon(Icons.copy_all, color: ColorUtils.addressGreen, size: 18.sp,)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
