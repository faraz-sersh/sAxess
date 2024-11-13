import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/boarding/boarding_two.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/btn_widget.dart';

class BoardingOneBottom extends StatelessWidget {
  const BoardingOneBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: SizeUtils.width.w,
        height: 100.h,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Btn(
              height: 50.h,
              width: 150.w,
              color: ColorUtils.grey,
              onTap: () {},
              child: TextUtils.txt(
                  text: "Skip", fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Btn(
              height: 50.h,
              width: 150.w,
              color: ColorUtils.primaryColor,
              onTap: () {
                Get.to(() => const BoardingTwo(),
                    transition: Transition.cupertino, duration: const Duration(milliseconds: 700));
              },
              child: TextUtils.txt(
                  text: "Next",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorUtils.white),
            ),
          ],
        ),
      ),
    );
  }
}
