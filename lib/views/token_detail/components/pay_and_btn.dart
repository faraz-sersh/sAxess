
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/text_utils.dart';

import '../../../utils/color_utils.dart';
import '../../../widgets/space_widget.dart';

class PayAndBtnWidget extends StatelessWidget {
  const PayAndBtnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: ColorUtils.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUtils.txt(
            text: "Pay",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorUtils.textGreyDark,
          ),
          Space.vertical(4.h),
          TextUtils.txt(text: "\$0.00", fontSize: 30),
          Space.vertical(2.h),
          TextUtils.txt(
            text: "0.00 BTC",
            fontSize: 14,
            color: ColorUtils.textGreyDark,
          ),
          Space.vertical(14.h),
          SizedBox(
            width: Get.width.w,
            height: 40.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  payBtn(Icons.arrow_downward_rounded, "Recieve", () {}),
                  payBtn(Icons.arrow_upward_rounded, "Send", () {}),
                  payBtn(CupertinoIcons.arrow_up_arrow_down, "Exchange", () {}),
                  payBtn(Icons.add, "Buy", () {}),
                  payBtn(CupertinoIcons.money_dollar, "Sell", () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget payBtn(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0.w, left: 2.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 130.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: ColorUtils.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: ColorUtils.sBlack,
              ),
              Space.horizontal(8.w),
              TextUtils.txt(
                text: title,
                fontSize: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
