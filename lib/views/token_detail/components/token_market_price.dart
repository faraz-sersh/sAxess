import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skey/utils/text_utils.dart';

import '../../../utils/color_utils.dart';
import '../../../widgets/space_widget.dart';

class TokenMarketPriceWidget extends StatelessWidget {
  const TokenMarketPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 360.w,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: ColorUtils.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtils.txt(
                text: "Token Market Price",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorUtils.textGreyDark),
            Space.vertical(5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 150.w, child: TextUtils.txt(text: "\$67 335,31")),
                TextUtils.txt(
                    text: "2.7%",
                    color: ColorUtils.primaryColor,
                    fontWeight: FontWeight.w500),
                TextUtils.txt(
                  text: "24 hours",
                  color: ColorUtils.textGreyDark,
                ),
                // SizedBox(
                //   width: 80.w,
                //   child: Icon(
                //     Icons.show_chart_rounded,
                //     color: ColorUtils.primaryColor,
                //   ),
                // )
              ],
            )
          ],
        ));
  }
}
