import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

class PaymentSuccesfullScreen extends StatelessWidget {
  const PaymentSuccesfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: SizeUtils.width.w,
        height: SizeUtils.height.h,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Space.vertical(60.h),
                  Center(
                    child: SvgPicture.asset(
                      AssetUtils.successCheckmark,
                      width: 80.w,
                      height: 80.h,
                      color: ColorUtils.primaryColor,
                    ),
                  ),
                  Space.vertical(15.h),
                  TextUtils.txt(
                    text: "200.0 SERSH",
                    fontSize: 30,
                  ),
                  Space.vertical(10.h),
                  TextUtils.txt(
                      text: "Payment Successful",
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  Space.vertical(17.h),
                  SizedBox(
                    width: 292.w,
                    child: TextUtils.txt(
                      text:
                          "The recipent can check the balance in the Saxess Wallet",
                      textAlign: TextAlign.center,
                      color: ColorUtils.textGreyDark,
                    ),
                  ),
                  Space.vertical(50.h),
                  ListTile(
                    dense: true,
                    title: TextUtils.txt(
                        text: "To",
                        fontSize: 12,
                        color: ColorUtils.textGreyDark),
                    trailing: SizedBox(
                      width: 220.w,
                      child: TextUtils.txt(
                          textAlign: TextAlign.end,
                          text: "0x12343545345384868768468",
                          fontSize: 12),
                    ),
                  ),
                  ListTile(
                    dense: true,

                    title: TextUtils.txt(
                        text: "Transaction ID",
                        fontSize: 12,
                        color: ColorUtils.textGreyDark),
                    trailing: SizedBox(
                      width: 220.w,
                      child: TextUtils.txt(
                          textAlign: TextAlign.end,
                          text: "12343545345384868768468",
                          fontSize: 12),
                    ),
                  ),
                  ListTile(
                    dense: true,

                    title: TextUtils.txt(
                        text: "Paid with",
                        fontSize: 12,
                        color: ColorUtils.textGreyDark),
                    trailing: SizedBox(
                      width: 220.w,
                      child: TextUtils.txt(
                          textAlign: TextAlign.end,
                          text: "Saxess Wallet",
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Btn(
                    height: 48.h,
                    width: Get.width.w,
                    color: ColorUtils.primaryColor,
                    child: TextUtils.txt(
                        text: "Send another Transaction",
                        fontSize: 16,
                        color: ColorUtils.white),
                    onTap: () {
                      Get.close(2);
                    }),
              ),
              AppBarWidget(
                title: "",
                onBack: () {
                  Get.close(2);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
