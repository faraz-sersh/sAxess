import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/create_wallet_options/create_wallet_option.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/pin_field.dart';
import 'package:skey/widgets/space_widget.dart';

class NewCardPinScreen extends StatelessWidget {
  NewCardPinScreen({super.key});

  TextEditingController newPin = TextEditingController();
  TextEditingController confirmNewPin = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Space.vertical(100.h),

                          TextUtils.txt(text: "Enter New Pin", fontSize: 26),
                          Space.vertical(10.h),
                          PinField(controller: newPin),
                          Space.vertical(30.h),
                          TextUtils.txt(text: "Confirm New Pin", fontSize: 26),
                          Space.vertical(10.h),
                          PinField(
                            controller: confirmNewPin,
                            match: newPin.text,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Btn(
                        height: 48.h,
                        width: Get.width.w,
                        color: ColorUtils.primaryColor,
                        child: TextUtils.txt(
                            text: "Set Pin",
                            fontSize: 16,
                            color: ColorUtils.white),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(() => const CreateWalletOptionScreen(),
                              transition: Transition.circularReveal,
                              duration: const Duration(seconds: 1));
                          //if (formKey.currentState!.validate()) {}
                        }),
                  ),
                  const AppBarWidget(title: "Set Card Pin")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
