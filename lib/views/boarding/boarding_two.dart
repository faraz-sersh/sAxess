import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/boarding_controller.dart';
import 'package:skey/utils/asset_utils.dart';

import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/boarding/components/progress_bar.dart';
import 'package:skey/widgets/space_widget.dart';

import 'components/boarding_two_bottom.dart';

class BoardingTwo extends StatefulWidget {
   const BoardingTwo({super.key});

  @override
  State<BoardingTwo> createState() => _BoardingTwoState();
}

class _BoardingTwoState extends State<BoardingTwo> {
  final controller = Get.find<BoardingController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.opacityTwo.value = 0.0;
    Future.delayed(const Duration(milliseconds: 200), () {
      controller.opacityTwo.value = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BoardingTwoBottom(),
      body: SizedBox(
        width: SizeUtils.width.w,
        child: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          children: [
            backgorundImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Space.vertical(40.h),
                const BoardingProgressWidget(
                  progress: 66,
                ),
                Space.vertical(60.h),
                titleText(),
                Space.vertical(15.h),
                subtitleText()
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget backgorundImage() {
    return Obx(() =>  AnimatedOpacity(
      opacity: controller.opacityTwo.value,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      child: SizedBox(
        width: SizeUtils.width.w,
        height: SizeUtils.height.h,
        child: Image.asset(
          AssetUtils.boarding2,
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
                'You must lift your thumb off the biometric sensor after each step to fully capture all angles of your thumbprint.',
            textAlign: TextAlign.center,
            fontSize: 16));
  }

  SizedBox titleText() {
    return SizedBox(
      width: 330.w,
      height: 95.h,
      child: Stack(
        children: [
          Positioned(
            left: 290.w,
            top: 0.h,
            child: SizedBox(
              width: 30.w,
              height: 29.h,
              child: SvgPicture.asset(AssetUtils.logoGreen),
            ),
          ),
          TextUtils.txt(
              text: 'Connectivity of\nthe New Generation',
              fontSize: 35,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
