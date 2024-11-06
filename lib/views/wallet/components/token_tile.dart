import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skey/views/token_detail/token_detail_screen.dart';

import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/space_widget.dart';

class TokenTile extends StatelessWidget {
  const TokenTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: (){
          Get.to(() => TokenDetailScreen(), transition: Transition.cupertino);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              AssetUtils.btcIcon,
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
                        text: "Bitcoin", fontSize: 17, fontWeight: FontWeight.w500),
                    TextUtils.txt(
                        text: "0.072 BTC",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Space.vertical(4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils.txt(
                        text: '\$45,294.10',
                        fontSize: 14,
                        color: ColorUtils.sBlack),
                    TextUtils.txt(
                        text: '\$2714', fontSize: 14, color: ColorUtils.sBlack),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
