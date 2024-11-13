import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/manage_tokens/manage_token_screen.dart';
import 'package:skey/views/settings/settings_screen.dart';
import 'package:skey/views/wallet/components/wallet_token_list.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/loader.dart';
import 'package:skey/widgets/space_widget.dart';

import 'components/wallet_balance_widget.dart';
import 'components/wallet_address_widget.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.darkGrey,
      body: SafeArea(
          child: SizedBox(
        width: SizeUtils.width.w,
        height: SizeUtils.height.h,
        child: Obx(() => controller.load.value
            ? Center(
                child: loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    LiquidPullToRefresh(
                      backgroundColor: ColorUtils.white,
                      color: ColorUtils.primaryColor,

                      onRefresh: () async {
                        await controller.getAllBalance();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Space.vertical(12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  AssetUtils.logoGreen,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => const SettingsScreen(),
                                          transition: Transition.cupertino);
                                    },
                                    icon: const Icon(CupertinoIcons.settings))
                              ],
                            ),
                            Space.vertical(20.h),
                            CardStackAndBalanceWidget(),
                            Space.vertical(12.h),
                            WalletAddress(),
                            Space.vertical(12.h),
                            WalletTokenList(
                              height: 350.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Btn(
                          height: 50.h,
                          width: Get.width.w,
                          color: ColorUtils.sBlack,
                          child: TextUtils.txt(
                              text: "Manage Tokens",
                              fontSize: 16,
                              color: ColorUtils.white),
                          onTap: () async {
                            //await controller.getSershBalance();
                            Get.to(() => const ManageTokenScreen(),
                                transition: Transition.cupertino);
                          }),
                    )
                  ],
                ),
              )),
      )),
    );
  }
}
