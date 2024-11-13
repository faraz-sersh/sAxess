import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/card_setup_success/card_setup_sucess.dart';

import '../../utils/color_utils.dart';
import '../../utils/text_utils.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/form_field.dart';
import '../../widgets/space_widget.dart';
import 'components/phone_field.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          text: 'Tell us about yourself',
                          fontSize: 30,
                        ),
                      ),
                      Space.vertical(12),
                      MyFormField(
                        controller: firstName,
                        hint: "First Name",
                      ),
                      Space.vertical(15),
                      MyFormField(
                        controller: lastName,
                        hint: "Last Name",
                      ),
                      Space.vertical(15),
                      MyPhoneField(
                        controller: phoneCont,
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
                          // if(formKey.currentState!.validate()){
                          //
                          // }
                          Get.offAll(() => const CardSetupSucessScreen(),
                              transition: Transition.circularReveal,
                              duration: const Duration(seconds: 1));
                        }),
                  ],
                ),
              ),
              const AppBarWidget(title: "Register Yourself")
            ],
          ),
        ),
      )),
    );
  }
}
