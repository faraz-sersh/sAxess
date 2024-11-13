import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/views/wallet/components/token_tile.dart';

import '../../../utils/color_utils.dart';

class WalletTokenList extends StatelessWidget {
  WalletTokenList({
    super.key,
    required this.height,
  });

  final double height;
  final controller = Get.find<WalletController>();

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
        primary: false,
        child: Obx(() =>  Column(
          children: [
            for (int i = 0; i < controller.tokens.length; i++)
                TokenTile(
                  token: controller.tokens[i],
                  // logo: AssetUtils.bnbIcon,
                  // symbol: "TBNB",
                  // balance: controller.balance.value.toStringAsFixed(6),
                ),
            // TokenTile(
            //   logo: AssetUtils.logoGreen,
            //   symbol: "SERSH",
            //   balance: controller.sershBalance.value.toStringAsFixed(6),
            // ),
            // Space.vertical(40.h)
          ],
        )),
      ),
    );
  }
}
