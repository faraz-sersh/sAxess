import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/boarding_controller.dart';
import 'package:skey/utils/asset_utils.dart';

import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/boarding/components/second_animated_row.dart';
import 'package:skey/views/boarding/components/third_animated_row.dart';
import 'package:skey/widgets/space_widget.dart';
import 'components/boarding_one_bottom.dart';
import 'components/first_animated_row.dart';
import 'components/progress_bar.dart';

class BoardingOne extends StatefulWidget {
  const BoardingOne({super.key});

  @override
  State<BoardingOne> createState() => _BoardingOneState();
}

class _BoardingOneState extends State<BoardingOne>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(BoardingController());

  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   animationController.stop();
  //   animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BoardingOneBottom(),
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
                  progress: 33,
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
    return Container(
      alignment: Alignment.center,
      width: SizeUtils.width.w,
      height: SizeUtils.height.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Space.vertical(150.h),
          Row(
            children: [
              FirstAnimatedRow(
                animationController: animationController,
              ),
            ],
          ),
          Space.vertical(30.h),
          Row(
            children: [
              SecondAnimatedRow(
                animationController: animationController,
              ),
            ],
          ),
          Space.vertical(30.h),
          Row(
            children: [
              ThirdAnimatedRow(
                animationController: animationController,
              ),
            ],
          ),
          Space.vertical(30.h),
        ],
      ),
    );
  }

  SizedBox subtitleText() {
    return SizedBox(
        width: 285.w,
        child: TextUtils.txt(
            text:
                'A hardware wallet for you Bitcoin.\nEthereum and many more currencies all at once-all in one card',
            textAlign: TextAlign.center,
            fontSize: 16));
  }

  SizedBox titleText() {
    return SizedBox(
      width: 225.w,
      height: 95.h,
      child: Stack(
        children: [
          Positioned(
            left: 190.w,
            top: 0.h,
            child: SizedBox(
              width: 30.w,
              height: 29.h,
              child: SvgPicture.asset(AssetUtils.logoGreen),
            ),
          ),
          TextUtils.txt(
              text: "Thousands\nof currencies",
              fontSize: 35,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
