import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';

import '../../../utils/text_utils.dart';
import '../../../widgets/space_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.w,
      //color: ColorUtils.white,
      alignment: Alignment.center,
      height: 60.h,
      child: Row(
        children: [
          InkWell(
            onTap: onBack ?? () {
                    Get.back();
                  },
            child: Container(
              width: 50.w,
              height: 50.h,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: ColorUtils.grey, shape: BoxShape.circle),
              child: Icon(Icons.arrow_back_rounded),
            ),
          ),
          Space.horizontal(16.w),
          TextUtils.txt(
            text: title,
            textAlign: TextAlign.center,
            fontSize: 23,
          )
        ],
      ),
    );
  }
}
