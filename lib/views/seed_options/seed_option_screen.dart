import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/seed_phrase/seed_phrase_screen.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../utils/asset_utils.dart';

class SeedOptionScreen extends StatelessWidget {
  const SeedOptionScreen({super.key});

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
                  Space.vertical(180.h),
                  Center(child: SvgPicture.asset(AssetUtils.logoGreen, width: 80.w, height: 80.h,)),
                  Space.vertical(100.h),
                  SizedBox(
                    width: 292.w,
                    child: TextUtils.txt(
                      text: 'Use seed phrase',
                      textAlign: TextAlign.center,
                      fontSize: 30,
                    ),
                  ),
                  Space.vertical(15.h),
                  SizedBox(
                    width: 292.w,
                    child: TextUtils.txt(
                      text:"When you set up your sAxess hardware wallet, a recovery phrase of 12 to 24 words is generated. This recovery phrase is the key to accessing your digital assets. If your sAxess card is ever lost or damaged, you will need this phraseto recover your assets.",
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
                            text: "Generate Seed",
                            color: ColorUtils.white,
                            fontSize: 16),
                        onTap: () {
                          Get.to(() => SeedPhraseScreen(), transition: Transition.cupertino);
                        }),
                    Space.vertical(12.h),
                    Btn(
                        height: 48.h,
                        width: Get.width.w,
                        color: ColorUtils.grey,
                        child:
                            TextUtils.txt(text: "Import Wallet", fontSize: 16),
                        onTap: () {}),
                  ],
                ),
              ),
              AppBarWidget(title: "Create Wallet"),
            ],
          ),
        ),
      )),
    );
  }
}
