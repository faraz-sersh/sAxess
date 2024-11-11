import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/helpers/helpers.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';

class WalletAddress extends StatelessWidget {
  WalletAddress({
    super.key,
  });

  final controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width.w,
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            TextUtils.txt(
              text: 'Address :',
              color: ColorUtils.sBlack,
              fontSize: 18,
            ),
            Space.horizontal(16.w),
            Container(
              height: 30.h,
              width: 200.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorUtils.addressGreen.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUtils.txt(text: obscureMiddle(controller.address.value), fontSize: 13),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: controller.address.value));
                          ToastUtils.showToast(
                              message: "Address Copied");
                        },
                        child: Icon(
                          Icons.copy_all,
                          color: ColorUtils.addressGreen,
                          size: 18.sp,
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
