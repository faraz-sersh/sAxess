import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/views/send_token_address/send_token_address_screen.dart';
import 'package:skey/views/token_detail/token_detail_screen.dart';
import 'package:skey/views/wallet/wallet_screen.dart';

import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/space_widget.dart';

class TokenTile extends StatelessWidget {
  TokenTile({
    super.key,
    required this.logo, required this.symbol,
    required this.balance
  });


  final String logo;
  final String symbol;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SendTokenAddressScreen(symbol: symbol), transition: Transition.cupertino);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              logo,
              width: 40.w,
              height: 40.h,
            ),
            Space.horizontal(10.w),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils.txt(
                        text: symbol,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    TextUtils.txt(
                        text:
                            "$balance $symbol",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Space.vertical(4.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextUtils.txt(
                //         text: '\$45,294.10',
                //         fontSize: 14,
                //         color: ColorUtils.sBlack),
                //     TextUtils.txt(
                //         text: '\$2714', fontSize: 14, color: ColorUtils.sBlack),
                //   ],
                // ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
