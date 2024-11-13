import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/token_detail/components/token_market_price.dart';
import 'package:skey/views/token_detail/components/transaction_list.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/space_widget.dart';

import 'components/pay_and_btn.dart';

class TokenDetailScreen extends StatelessWidget {
  const TokenDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.darkGrey,
      body: SafeArea(
          child: SizedBox(
        width: SizeUtils.width.w,
        height: SizeUtils.height.h,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Space.vertical(100.h),
                  ListTile(
                    title: TextUtils.txt(
                        text: "Bitoin",
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                    subtitle: TextUtils.txt(
                        text: "Main Network",
                        fontSize: 14,
                        color: ColorUtils.textGreyDark),
                    trailing: SvgPicture.asset(
                      AssetUtils.btcIcon,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  Space.vertical(12.h),
                  const PayAndBtnWidget(),
                  Space.vertical(20.h),
                  const TokenMarketPriceWidget(),
                  Space.vertical(20.h),
                  const TransactionList()
                ],
              ),
              const AppBarWidget(title: "Bitcoin")
            ],
          ),
        ),
      )),
    );
  }
}
