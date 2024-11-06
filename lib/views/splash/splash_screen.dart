import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/splash_controller.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // void listenToEventOne() {
  //   androidEventPlatform.receiveBroadcastStream().listen((event) {
  //     print('Received Event One: $event');
  //   }, onError: (error) {
  //     print('Error: $error');
  //   }, onDone: () {
  //     print('Event One stream ended.');
  //   });
  // }
  // checkInitilazation() async {
  //   await androidPlatform.invokeMethod("initialized");
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //listenToEventOne();
    Get.put(SplashController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Center(
        child: SvgPicture.asset(
          AssetUtils.logoSplash
        ),
      ),
    );
  }
}
