import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/toast_utils.dart';

import '../views/boarding/boarding_one.dart';

class SettingsController extends GetxController {
  TextEditingController oldPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  TextEditingController confirmNewPin = TextEditingController();
  RxString newPinValue = "".obs;
  RxBool load = false.obs;

  changePin() async {
    try {
      if (oldPin.text == newPin.text) {
        ToastUtils.showToast(
            message: "Your new pin must be different from old pin.",
            textColor: ColorUtils.white,
            backgroundColor: Colors.red);
      } else {
        if(Platform.isIOS) {
          load.value = true;
          final res = await iosPlatform.invokeMethod("changePin", {
            "oldPin": oldPin.text,
            "newPin": newPin.text,
          });
          if (res == "success") {
            Future.delayed(Duration(milliseconds: 1700), () {
              load.value == false;
              clear();
              Get.back();
            });
          }
        }
      }
    } catch (e) {
      load.value = false;
      print(e);
      ToastUtils.showToast(
          message: "Error Occurred!", backgroundColor: Colors.red);
    }
  }

  unpairCard() async {
    try {
      if (Platform.isIOS) {
        final result = await iosPlatform.invokeMethod("unpairCard");
        if (result == "Not Paired") {
          ToastUtils.showToast(
              message: "Card Not Paired", backgroundColor: Colors.red);
        } else if (result == "unpaired") {
          Get.offAll(() => const BoardingOne());
        } else {
          ToastUtils.showToast(
              message: "Error Occurred!", backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e);
      ToastUtils.showToast(
          message: "Error Occurred!",
          backgroundColor: Colors.red,
          textColor: ColorUtils.white);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPin.dispose();
    newPin.dispose();
    confirmNewPin.dispose();
  }

  clear(){
    oldPin.clear();
    newPin.clear();
    confirmNewPin.clear();
  }
}
