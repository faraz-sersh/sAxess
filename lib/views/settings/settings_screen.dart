import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/main.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/views/boarding/boarding_one.dart';
import 'package:skey/views/settings/change_pin_screen.dart';

import '../../controllers/settings_controlller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: TextUtils.txt(text: "Settings", fontSize: 20),
        elevation: 0.0,
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: TextUtils.txt(text: "Get Card Status", fontSize: 16),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            ),
            ListTile(
              onTap: () {
                controller.clear();
                Get.to(() => ChangePinScreen(),
                    transition: Transition.cupertino);
              },
              title: TextUtils.txt(text: "Change Card Pin", fontSize: 16),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r), color: Colors.red),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () async {
                  await controller.unpairCard();
                },
                title: TextUtils.txt(
                    text: "Unpair Card", fontSize: 16, color: ColorUtils.white),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorUtils.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
