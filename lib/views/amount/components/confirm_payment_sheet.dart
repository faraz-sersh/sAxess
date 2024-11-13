import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/transaction_controller.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/payment_successfull/payment_succesfull_screen.dart';
import 'package:skey/widgets/loader.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/btn_widget.dart';

confirmPaymentSheet(context, TransactionController controller) {
  return Get.bottomSheet(

    Container(
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
                    Get.back();

                    Future.delayed(Duration(milliseconds: 100), () {
                      FocusScope.of(context).unfocus();
                    });
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
                text: "${controller.addressCont.text}",
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
                      text:
                          "${controller.amount.text} ${controller.selectedToken.value!.symbol.toUpperCase()}",
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
                Obx(() => SizedBox(
                      width: 180.w,
                      child: TextUtils.txt(
                          textAlign: TextAlign.end,
                          text:
                              "${(controller.balance.value)} ${controller.selectedToken.value!.symbol.toUpperCase()}",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorUtils.textGreyDark),
                    )),
              ],
            ),
          ),
          Spacer(),
          Obx(() => controller.load.value
              ? Center(
                  child: loader(),
                )
              : Btn(
                  height: 48.h,
                  width: Get.width.w,
                  color: ColorUtils.primaryColor,
                  child: TextUtils.txt(
                      text: "Confirm", fontSize: 16, color: ColorUtils.white),
                  onTap: () async {
                    if (controller.selectedToken.value!.symbol == "SERSH") {
                      await controller.makeTxCoin(context,);
                    } else {
                      await controller.makeTxToken(context);
                    }
                    // Get.to(() => PaymentSuccesfullScreen(),
                    //     transition: Transition.cupertino);
                  })),
          Space.vertical(20.h),
        ],
      ),
    ),
    isDismissible: false,
  );
}
