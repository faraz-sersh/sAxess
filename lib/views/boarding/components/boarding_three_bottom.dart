import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/card_pin/existing_card_pin.dart';
import 'package:skey/views/card_pin/new_card_pin.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/btn_widget.dart';

class BoardingThreeBottom extends StatelessWidget {
  const BoardingThreeBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: SizeUtils.width.w,
        height: 100.h,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.transparent,
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [Colors.white.withOpacity(0), Colors.white],
          ),
        ),
        padding: EdgeInsets.only(bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Btn(
              height: 50.h,
              width: 160.w,
              color: ColorUtils.primaryColor,
              onTap: () async {
                //Android
                // if (Platform.isAndroid) {
                //   final popupController = Get.find<PopUpController>();
                //   popupController.showPopup(context);
                //   listenToAndroidStream(popupController);
                // }

                // final res  = await iosPlatform.invokeMethod('sendTransaction', {"to" : "1234"});
                // print(res);
                Get.to(() => const ExistingCardPinScreen(),
                    transition: Transition.circularReveal);
                //showPopup(context);
                //NativeDataHandler.initialize();
              },
              child: TextUtils.txt(
                  text: "Existing Card",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorUtils.white),
            ),
            Btn(
              height: 50.h,
              width: 160.w,
              color: ColorUtils.primaryColor,
              onTap: () async {
                //Android
                if (Platform.isAndroid) {
                  final popupController = Get.find<PopUpController>();
                  popupController.showPopup(context);
                  listenToAndroidStream(popupController);
                }
                if (Platform.isIOS) {
                  // final res  = await iosPlatform.invokeMethod('sendTransaction', {"to" : "1234"});
                  // print(res);
                  Get.to(() => NewCardPinScreen(),
                      transition: Transition.circularReveal);
                  //showPopup(context);
                  //NativeDataHandler.initialize();
                }
              },
              child: TextUtils.txt(
                  text: "New Card",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorUtils.white),
            ),
          ],
        ),
      ),
    );
  }

  void listenToAndroidStream(popupController) async {
    popupController.content.value = "Waiting For Card";
    popupController.eventSubscription.value =
        androidPairEvent.receiveBroadcastStream().listen((event) async {
      print(event);
      popupController.content.value = event;
      // if(event == "Card Paired Successfully"){
      //   await popupController.eventSubscription.value?.cancel();
      //   popupController.closePopup();
      //   Get.offAll(() => WalletScreen(), transition: Transition.cupertino);
      // }
    }, onError: (error) {
      popupController.content.value = "Error";
      print('Error: $error');
    }, onDone: () async {
      Future.delayed(const Duration(seconds: 1), () async {
        print('Stream has ended.');
        await popupController.eventSubscription.value?.cancel();
        popupController.closePopup();
      });
    });
  }
}
