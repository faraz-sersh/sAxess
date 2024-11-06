import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/wallet/components/wallet_token_list.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';

class ManageTokenScreen extends StatelessWidget {
  const ManageTokenScreen({super.key});

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
              Padding(
                padding:  EdgeInsets.only(top : 120.0.h),
                child: WalletTokenList(height: Get.height.h,),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Btn(
                    height: 50.h,
                    width: SizeUtils.width.w,
                    color: ColorUtils.sBlack,
                    child: TextUtils.txt(
                        text: "Save Changes",
                        fontWeight: FontWeight.w500,
                        color: ColorUtils.white,
                        fontSize: 16),
                    onTap: (){
                      Get.back();
                    }),
              ),
              AppBarWidget(title: "Manage Token")
            ],
          ),
        ),
      )),
    );
  }
}
