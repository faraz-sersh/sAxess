import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/views/auth/email_address_screen.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../utils/color_utils.dart';
import '../../utils/text_utils.dart';
import '../../widgets/btn_widget.dart';

class ExistingSeedScreen extends StatelessWidget {
  const ExistingSeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: SizedBox(
              width: SizeUtils.width.w,
              height: SizeUtils.height.h,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Space.vertical(100.h),
                          Center(
                            child: SizedBox(
                              width: 292.w,
                              child: TextUtils.txt(
                                text: 'Enter Existing Seed Phrase',
                                textAlign: TextAlign.center,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Space.vertical(15.h),
                          // Center(
                          //   child: SizedBox(
                          //     width: 292.w,
                          //     child: TextUtils.txt(
                          //       text:
                          //       'A hardware wallet for you Bitcoin.\nEthereum and many more currencies all at once-all in one card',
                          //       textAlign: TextAlign.center,
                          //       fontSize: 16,
                          //     ),
                          //   ),
                          // ),
                          Space.vertical(30.h),
                          TextUtils.txt(
                              text: "Wallet Seed Phrase",
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          Space.vertical(10.h),
                          Container(
                            width: Get.width.w,
                            //height: 100.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: ColorUtils.grey,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: TextFormField(
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Btn(
                              height: 48.h,
                              width: Get.width.w,
                              color: ColorUtils.primaryColor,
                              child: TextUtils.txt(
                                  text: "Continue",
                                  color: ColorUtils.white,
                                  fontSize: 16),
                              onTap: () {
                                Get.to(() => EmailAddressScreen(), transition: Transition.cupertino);
                              }),
                        ],
                      ),
                    ),
                    AppBarWidget(title: "Create Wallet")
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
