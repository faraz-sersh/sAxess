import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/widgets/loader.dart';
import 'package:skey/widgets/space_widget.dart';

class PopupWidget extends StatelessWidget {
  //final StreamSubscription? stream;

  PopupWidget();

  final controller = Get.find<PopUpController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(20),
          width: Get.width.w,
          height: (Get.height * 0.6).h,
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Obx(() =>
                  //     TextUtils.txt(text: controller.content.value, fontSize: 20)),
                  // SizedBox(height: 20),
                  // loader(),
                  // SizedBox(height: 20),
                  if (controller.content.value == "Done") ...[successDone()],
                  if (controller.content.value == "Card Already Paired") ...[
                    errorWidget()
                  ],
                  if (controller.content.value == "Error") ...[errorWidget()],
                  if (controller.content.value == "Waiting For Card") ...[
                    cardWaiting()
                  ],
                  if (controller.content.value ==
                      "Fingerprint Verification" || controller.content.value == "Connected to card") ...[fingerprintVerification()]

                  // ElevatedButton(
                  //   onPressed: () {
                  //
                  //     print("close");
                  //   },
                  //   child: Text("Close"),
                  // ),
                ],
              )),
        ),
      ),
    );
  }

  Widget cardWaiting() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  controller.closePopup();
                  if (controller.eventSubscription.value != null) {
                    print("..stopping");
                    controller.eventSubscription.value?.cancel().then((_) {
                      print('Stream cancelled');
                      controller.eventSubscription.value =
                          null; // Reset the subscription
                    }).catchError((error) {
                      print('Error while cancelling stream: $error');
                    });
                  }
                },
                child: Icon(
                  Icons.close,
                  color: ColorUtils.sBlack,
                )),
          ],
        ),
        Space.vertical(10.h),
        SvgPicture.asset(
          AssetUtils.waitingCardSvg,
          width: 90.w,
          height: 90.h,
        ),
        Space.vertical(20.h),
        SizedBox(
          width: 393.w,
          child: TextUtils.txt(
            text: 'Put down for scanning',
            textAlign: TextAlign.center,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Space.vertical(8.h),
        SizedBox(
          width: 285.w,
          child: TextUtils.txt(
            text:
                'You must lift your thumb off the biometric sensor after each step to fully capture all angles of your thumbprint.',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget fingerprintVerification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  controller.closePopup();
                  if (controller.eventSubscription.value != null) {
                    print("..stopping");
                    controller.eventSubscription.value?.cancel().then((_) {
                      print('Stream cancelled');
                      controller.eventSubscription.value =
                          null; // Reset the subscription
                    }).catchError((error) {
                      print('Error while cancelling stream: $error');
                    });
                  }
                },
                child: Icon(
                  Icons.close,
                  color: ColorUtils.sBlack,
                )),
          ],
        ),
        Space.vertical(10.h),
        SvgPicture.asset(
          AssetUtils.fingerprintVerification,
          width: 90.w,
          height: 90.h,
        ),
        Space.vertical(20.h),
        SizedBox(
          width: 393.w,
          child: TextUtils.txt(
            text: 'Verifying the Fingerprint',
            textAlign: TextAlign.center,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Space.vertical(8.h),
        SizedBox(
          width: 285.w,
          child: TextUtils.txt(
            text:
                'Press the card as shown above and hold until the operation is finished',
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget successDone() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  controller.closePopup();
                  if (controller.eventSubscription.value != null) {
                    print("..stopping");
                    controller.eventSubscription.value?.cancel().then((_) {
                      print('Stream cancelled');
                      controller.eventSubscription.value =
                          null; // Reset the subscription
                    }).catchError((error) {
                      print('Error while cancelling stream: $error');
                    });
                  }
                },
                child: Icon(
                  Icons.close,
                  color: ColorUtils.sBlack,
                )),
          ],
        ),
        Space.vertical(10.h),
        SvgPicture.asset(
          AssetUtils.scanDone,
          width: 100.w,
          height: 100.h,
        ),
        Space.vertical(20.h),
        Obx(() => SizedBox(
              width: 393.w,
              child: TextUtils.txt(
                text: controller.content.value,
                textAlign: TextAlign.center,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    );
  }

  Widget errorWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 100.sp,
        ),
        Space.vertical(20.h),
        Obx(() => SizedBox(
              width: 393.w,
              child: TextUtils.txt(
                text: controller.content.value,
                textAlign: TextAlign.center,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    );
  }
}
