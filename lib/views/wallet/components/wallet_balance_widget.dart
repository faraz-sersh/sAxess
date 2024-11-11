import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/widgets/space_widget.dart';

class CardStackAndBalanceWidget extends StatelessWidget {
   CardStackAndBalanceWidget({
    super.key,
  });

  final controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width.w,
      height: 120.h,
      child: Stack(
        children: [
          SvgPicture.asset(
            AssetUtils.homeCardStack,
            width: Get.width.w,
            height: 120.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextUtils.txt(
                      text: "Wallet",
                      fontSize: 14,
                      color: ColorUtils.sBlack.withOpacity(0.6),
                      fontWeight: FontWeight.w500),
                  Space.vertical(2.h),
                  Obx(() =>  SizedBox(
                    width: 160.w,
                    child: TextUtils.txt(
                        text: '${controller.balance.value.toStringAsFixed(4)} TBNB',
                        color: ColorUtils.sBlack,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
