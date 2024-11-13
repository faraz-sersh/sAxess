import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/wallet/wallet_screen.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

class CardSetupSucessScreen extends StatelessWidget {
  const CardSetupSucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Btn(
            height: 50.h,
            width: Get.width,
            color: ColorUtils.primaryColor,
            child: TextUtils.txt(
                text: "Continue to my Wallet",
                color: ColorUtils.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.offAll(() => WalletScreen(),
                  transition: Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            }),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetUtils.successCheckmark,
                height: 80.h,
                width: 80.w,
                color: ColorUtils.primaryColor,
              ),
              Space.vertical(50.h),
              TextUtils.txt(
                text: 'Bravo!',
                textAlign: TextAlign.center,
                color: ColorUtils.sBlack,
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
              Space.vertical(20.h),
              TextUtils.txt(
                text:
                    "Your sAxess card has been well configured and ready to use your wallet.",
                textAlign: TextAlign.center,
                color: ColorUtils.sBlack,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
