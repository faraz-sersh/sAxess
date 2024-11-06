import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/existing_seed/existing_seed_screen.dart';
import 'package:skey/views/seed_options/seed_option_screen.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

class CreateWalletOptionScreen extends StatelessWidget {
  const CreateWalletOptionScreen({super.key});

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
                    Space.vertical(120.h),
                    Center(child: SvgPicture.asset(AssetUtils.card)),
                    Space.vertical(30.h),
                    SizedBox(
                      width: 292.w,
                      child: TextUtils.txt(
                        text: 'Generate key privately',
                        textAlign: TextAlign.center,
                        fontSize: 30,
                      ),
                    ),
                    Space.vertical(15.h),
                    SizedBox(
                      width: 292.w,
                      child: TextUtils.txt(
                        text:
                            'A hardware wallet for you Bitcoin.\nEthereum and many more currencies all at once-all in one card',
                        textAlign: TextAlign.center,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Btn(
                          height: 48.h,
                          width: Get.width.w,
                          color: ColorUtils.primaryColor,
                          child: TextUtils.txt(
                              text: "Create New Wallet",
                              color: ColorUtils.white,
                              fontSize: 16),
                          onTap: () {
                            Get.to(() => SeedOptionScreen(), transition: Transition.cupertino);
                          }),
                      Space.vertical(12.h),
                      Btn(
                          height: 48.h,
                          width: Get.width.w,
                          color: ColorUtils.grey,
                          child: TextUtils.txt(
                              text: "Import Wallet", fontSize: 16),
                          onTap: () {
                            Get.to(() => ExistingSeedScreen(), transition: Transition.cupertino);
                          }),
                    ],
                  ),
                ),
                const AppBarWidget(title: "Choose Wallet"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
