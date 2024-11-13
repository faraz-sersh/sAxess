import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/auth/personal_info_screen.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../utils/color_utils.dart';
import '../../utils/text_utils.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/form_field.dart';

class EmailAddressScreen extends StatelessWidget {
  EmailAddressScreen({super.key});

  final TextEditingController emailCont = TextEditingController();
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
                        SizedBox(
                          width: Get.width.w,
                          child: TextUtils.txt(
                            text: 'Your Email Address',
                            fontSize: 30,
                          ),
                        ),
                        Space.vertical(12),
                        MyFormField(
                          controller: emailCont,
                          hint: "Your Email",
                          emailValid: true,
                        ),
                        Space.vertical(15),
                        SizedBox(
                          width: 360.w,
                          child: TextUtils.txt(
                            text:
                                'A confirmation has just been sent to the verified email address on file for your account, please save this email for your records.',
                            color: ColorUtils.textGreyDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
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
                            // if (formKey.currentState!.validate()) {
                            //
                            // }
                            Get.to(() => PersonalInfoScreen(),
                                transition: Transition.cupertino);
                          }),
                    ],
                  ),
                ),
                const AppBarWidget(title: "Register Yourself")
              ],
            ),
          ),
        )),
      ),
    );
  }
}
