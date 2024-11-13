import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/controllers/settings_controlller.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/pin_field.dart';
import 'package:skey/widgets/space_widget.dart';

class ChangePinScreen extends StatelessWidget {
  ChangePinScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: TextUtils.txt(text: "Change Pin", fontSize: 20),
        elevation: 0.0,
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheet: Container(
        color: ColorUtils.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Btn(
                height: 48.h,
                width: Get.width.w,
                color: ColorUtils.primaryColor,
                child: TextUtils.txt(text: "Confirm", color: ColorUtils.white),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await controller.changePin();
                  }
                }),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.vertical(20.h),
                TextUtils.txt(
                    text:
                        "Choose a pin that will be used to pair the card with the sAxess app."),
                Space.vertical(20.h),
                TextUtils.txt(text: "Enter old pin", fontSize: 16),
                Space.vertical(5.h),
                PinField(controller: controller.oldPin),
                Space.vertical(15.h),
                TextUtils.txt(text: "New pin", fontSize: 16),
                Space.vertical(5.h),
                PinField(
                  controller: controller.newPin,
                  onChanged: (v) {
                    controller.newPinValue.value = v;
                  },
                ),
                Space.vertical(15.h),
                Obx(() => controller.newPinValue.value.length < 6
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextUtils.txt(text: "Confirm new pin", fontSize: 16),
                          Space.vertical(5.h),
                          PinField(
                            controller: controller.confirmNewPin,
                            match: controller.newPinValue.value,
                          ),
                        ],
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
