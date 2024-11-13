import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/android_nfc_popup.dart';

class PopUpController extends GetxController{
  OverlayEntry? _overlayEntry;
  RxString content = "Waiting for Card".obs;
  Rxn<StreamSubscription> eventSubscription = Rxn<StreamSubscription>();

  void showPopup(context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: (Get.height * 0.6).h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
        child: PopupWidget(),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void closePopup()  {
    _overlayEntry?.remove();
    _overlayEntry = null;
    //CardScreen.platform.invokeMethod("stopNFCListener");
  }


}