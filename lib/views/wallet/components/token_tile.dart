import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/model/token_model.dart';
import 'package:skey/views/send_token_address/send_token_address_screen.dart';

import '../../../utils/text_utils.dart';
import '../../../widgets/space_widget.dart';

class TokenTile extends StatelessWidget {
  const TokenTile({super.key, required this.token
      // required this.logo,
      // required this.symbol,
      // required this.balance
      });

  final Token token;

  // final String logo;
  // final String symbol;
  // final String balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: () {
         // print(convertEthToWei(20));
          Get.to(
              () => SendTokenAddressScreen(
                    token: token,
                  ),
              transition: Transition.cupertino);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              token.logo,
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
                        text: token.symbol,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    TextUtils.txt(
                        text: "${token.balance.toStringAsFixed(4)} ${token.symbol}",
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
