import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/settings/settings_screen.dart';
import 'package:skey/views/splash/splash_screen.dart';


const androidPlatform = MethodChannel("com.serenity.skey");
const androidEventPlatform = EventChannel("com.serenity.skey/event");
const androidPairEvent = EventChannel("com.serenity.skey/pair");
const androidstreamPlatform = EventChannel("com.serenity.skey/streamChannel");

const iosPlatform = MethodChannel("com.example.skey/nfc");



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid){
      Get.put(PopUpController());
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(SizeUtils.width, SizeUtils.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: ColorUtils.primaryColor,
              fontFamily: "Outfit",
              scaffoldBackgroundColor: ColorUtils.white),
          home: child,
        );
      },
      child: const SettingsScreen(),
      //child: AmountScreen(),
    );
  }
}
