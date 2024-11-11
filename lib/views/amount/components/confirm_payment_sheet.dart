import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/payment_successfull/payment_succesfull_screen.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/btn_widget.dart';

confirmPaymentSheet() {
  return Get.bottomSheet(Container(
    width: Get.width.w,
    height: (SizeUtils.height * 0.5).h,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: ColorUtils.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Space.horizontal(20.w),
            TextUtils.txt(
                text: "Confirm Payment",
                fontSize: 18,
                fontWeight: FontWeight.w500),
            GestureDetector(
                onTap: () {
                  Get.close(1);
                },
                child: Icon(Icons.close))
          ],
        ),
        Space.vertical(20.h),
        TextUtils.txt(
            text: "Send to", fontSize: 12, fontWeight: FontWeight.w500),
        Space.vertical(8.h),
        Container(
          width: Get.width.w,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1.w, color: ColorUtils.grey)),
          child: TextUtils.txt(
              text: "0x1704523254712468412314687321357834534",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorUtils.textGreyDark),
        ),
        Space.vertical(8.h),
        TextUtils.txt(
            text: "Amount", fontSize: 12, fontWeight: FontWeight.w500),
        Space.vertical(8.h),
        Container(
          width: Get.width.w,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1.w, color: ColorUtils.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160.w,
                child: TextUtils.txt(
                    textAlign: TextAlign.start,
                    text: "Payee Receives",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.textGreyDark),
              ),
              SizedBox(
                width: 180.w,
                child: TextUtils.txt(
                    textAlign: TextAlign.end,
                    text: "200.0 SERSH",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.textGreyDark),
              ),
            ],
          ),
        ),
        Space.vertical(8.h),
        TextUtils.txt(
            text: "Balance", fontSize: 12, fontWeight: FontWeight.w500),
        Space.vertical(8.h),
        Container(
          width: Get.width.w,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1.w, color: ColorUtils.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160.w,
                child: TextUtils.txt(
                    textAlign: TextAlign.start,
                    text: "Remaining Balance",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.textGreyDark),
              ),
              SizedBox(
                width: 180.w,
                child: TextUtils.txt(
                    textAlign: TextAlign.end,
                    text: "800.0 SERSH",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.textGreyDark),
              ),
            ],
          ),
        ),
        Spacer(),
        Btn(
            height: 48.h,
            width: Get.width.w,
            color: ColorUtils.primaryColor,
            child: TextUtils.txt(
                text: "Confirm", fontSize: 16, color: ColorUtils.white),
            onTap: () {
              Get.to(() => PaymentSuccesfullScreen(),
                  transition: Transition.cupertino);
            }),
        Space.vertical(20.h),
      ],
    ),
  ));
}
