import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/boarding_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';

import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/boarding/components/boarding_three_bottom.dart';
import 'package:skey/views/boarding/components/progress_bar.dart';
import 'package:skey/widgets/space_widget.dart';


class BoardingThree extends StatefulWidget {
  const BoardingThree({super.key});

  @override
  State<BoardingThree> createState() => _BoardingThreeState();
}

class _BoardingThreeState extends State<BoardingThree> {
  final controller = Get.find<BoardingController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.opacityThree.value = 0.0;
    Future.delayed(const Duration(milliseconds: 200), () {
      controller.opacityThree.value = 1.0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtils.width.w,
      height: SizeUtils.height.h,
      color: ColorUtils.white,
      child: Stack(
        children: [
          backgorundImage(),
          Scaffold(
            bottomNavigationBar: const BoardingThreeBottom(),
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: SizeUtils.width.w,
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Space.vertical(40.h),
                  const BoardingProgressWidget(
                    progress: 100,
                  ),
                  Space.vertical(60.h),
                  titleText(),
                  Space.vertical(15.h),
                  subtitleText()
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget backgorundImage() {
    return Obx(() => AnimatedOpacity(
          opacity: controller.opacityThree.value,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: SizedBox(
            width: SizeUtils.width.w,
            height: SizeUtils.height.h,
            child: Image.asset(
              AssetUtils.boarding3,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  SizedBox subtitleText() {
    return SizedBox(
        width: 285.w,
        child: TextUtils.txt(
            text:
                "Improves the security experience for advanced users Put the card to access the sBox Wallet",
            textAlign: TextAlign.center,
            fontSize: 16));
  }

  SizedBox titleText() {
    return SizedBox(
      width: 260.w,
      height: 95.h,
      child: Stack(
        children: [
          Positioned(
            left: 230.w,
            top: 0.h,
            child: SizedBox(
              width: 30.w,
              height: 29.h,
              child: SvgPicture.asset(AssetUtils.logoGreen),
            ),
          ),
          TextUtils.txt(
              text: 'Simple access\nto your sWallet',
              fontSize: 35,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
