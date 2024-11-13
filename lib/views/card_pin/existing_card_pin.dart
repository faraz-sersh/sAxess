import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/main.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/views/wallet/wallet_screen.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/pin_field.dart';
import 'package:skey/widgets/space_widget.dart';

class ExistingCardPinScreen extends StatefulWidget {
  const ExistingCardPinScreen({super.key});

  @override
  State<ExistingCardPinScreen> createState() => _ExistingCardPinScreenState();
}

class _ExistingCardPinScreenState extends State<ExistingCardPinScreen> {
  TextEditingController newPin = TextEditingController();

  TextEditingController confirmNewPin = TextEditingController();

  final formKey = GlobalKey<FormState>();



  void listenToAndroidStream() async {
    PopUpController controller = Get.find<PopUpController>();
    controller.showPopup(context);
    controller.content.value = "Waiting For Card";
    controller.eventSubscription.value =
        androidPairEvent.receiveBroadcastStream().listen((event) async {
          print(event);
          controller.content.value = event;
          if(event == "Card Paired Successfully" || event == "Card Already Paired"){
            await controller.eventSubscription.value?.cancel();
            controller.closePopup();
            Get.offAll(() => WalletScreen(), transition: Transition.cupertino);
          }
        }, onError: (error) {
          controller.content.value = "Error";
          print('Error: $error');
        }, onDone: () async {
          Future.delayed(const Duration(seconds: 1), () async {
            print('Stream has ended.');
            await controller.eventSubscription.value?.cancel();
            controller.closePopup();
          });
        });
  }

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
                          Space.vertical(150.h),

                          TextUtils.txt(
                              text: "Enter pin of your card", fontSize: 26),
                          Space.vertical(20.h),
                          PinField(controller: newPin),
                          // Space.vertical(30.h),
                          // TextUtils.txt(text: "Confirm New Pin", fontSize: 26),
                          // Space.vertical(10.h),
                          // PinField(
                          //   controller: confirmNewPin,
                          //   match: newPin.text,
                          // ),
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
                            text: "Pair Card",
                            fontSize: 16,
                            color: ColorUtils.white),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (Platform.isIOS) {
                              try {
                                final result = await iosPlatform.invokeMethod(
                                    'pairCard', {"pin": newPin.text});

                                if (result is Map) {
                                  FocusScope.of(context).unfocus();
                                  await Preferences.storeAddress(address: result['address']);
                                  Get.to(() => WalletScreen(),
                                      transition: Transition.circularReveal,
                                      duration: const Duration(seconds: 1));
                                }
                              } catch (e) {
                                print(e);
                                ToastUtils.showToast(
                                    message: "Error Occurred!",
                                    backgroundColor: Colors.red);
                              }
                            } else if (Platform.isAndroid) {
                             listenToAndroidStream();
                            }
                          }
                        }),
                  ),
                  const AppBarWidget(title: "Enter Card Pin")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
