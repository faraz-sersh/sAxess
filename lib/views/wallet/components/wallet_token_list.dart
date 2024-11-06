import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/views/wallet/components/token_tile.dart';

import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/space_widget.dart';

class WalletTokenList extends StatelessWidget {
  const WalletTokenList({
    super.key, required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.w,
      height: height,
      //height: (Get.height * 0.38).h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: ColorUtils.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 10; i++)
              TokenTile(),
            Space.vertical(40.h)
          ],
        ),
      ),
    );
  }
}
