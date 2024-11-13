import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/controllers/transaction_controller.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/widgets/appBar_widget.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/loader.dart';
import 'package:skey/widgets/space_widget.dart';

class PaymentSuccesfullScreen extends StatelessWidget {
  PaymentSuccesfullScreen({super.key});

  final controller = Get.find<TransactionController>();
  final walletController = Get.find<WalletController>();
  RxBool load = false.obs;
  GlobalKey repaintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: SizeUtils.width.w,
        height: SizeUtils.height.h,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              RepaintBoundary(
                key: repaintKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Space.vertical(60.h),
                      Center(
                        child: SvgPicture.asset(
                          AssetUtils.successCheckmark,
                          width: 80.w,
                          height: 80.h,
                          color: ColorUtils.primaryColor,
                        ),
                      ),
                      Space.vertical(15.h),
                      TextUtils.txt(
                        text:
                            "${controller.amount.text} ${controller.selectedToken.value!.symbol}",
                        fontSize: 30,
                      ),
                      Space.vertical(10.h),
                      TextUtils.txt(
                          text: "Payment Successful",
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      Space.vertical(17.h),
                      SizedBox(
                        width: 292.w,
                        child: TextUtils.txt(
                          text:
                              "The recipent can check the balance in the sAxess Wallet",
                          textAlign: TextAlign.center,
                          color: ColorUtils.textGreyDark,
                        ),
                      ),
                      Space.vertical(50.h),
                      ListTile(
                        dense: true,
                        title: TextUtils.txt(
                            text: "To",
                            fontSize: 12,
                            color: ColorUtils.textGreyDark),
                        trailing: SizedBox(
                          width: 220.w,
                          child: TextUtils.txt(
                              textAlign: TextAlign.end,
                              text: controller.addressCont.text,
                              fontSize: 12),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: TextUtils.txt(
                            text: "Transaction ID",
                            fontSize: 12,
                            color: ColorUtils.textGreyDark),
                        trailing: SizedBox(
                          width: 220.w,
                          child: TextUtils.txt(
                              textAlign: TextAlign.end,
                              text: controller.transactionId.value,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: TextUtils.txt(
                            text: "Paid with",
                            fontSize: 12,
                            color: ColorUtils.textGreyDark),
                        trailing: SizedBox(
                          width: 220.w,
                          child: TextUtils.txt(
                              textAlign: TextAlign.end,
                              text: "sAxess Wallet",
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() => load.value
                    ? loader()
                    : Btn(
                        height: 48.h,
                        width: Get.width.w,
                        color: ColorUtils.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share, color: ColorUtils.white,),
                            Space.horizontal(5.w),
                            TextUtils.txt(
                                text: "Share",
                                fontSize: 16,
                                color: ColorUtils.white),
                          ],
                        ),
                        onTap: () async {
                          try {
                            RenderRepaintBoundary boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                            var image = await boundary.toImage(pixelRatio: 2);
                            ByteData? bytedata= await image.toByteData(format: ImageByteFormat.png);
                            Uint8List pngBytes = bytedata!.buffer.asUint8List();
                            final directory = await getTemporaryDirectory();
                            final file = File("${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png");
                            await file.writeAsBytes(pngBytes);
                            XFile xfile = XFile(file.path);
                            Share.shareXFiles([xfile]);

                          } catch (e) {
                            //load.value = false;
                            ToastUtils.showToast(
                                message: "Error Occurred",
                                backgroundColor: Colors.red);
                            print(e);
                          }
                        })
                ),
              ),
              AppBarWidget(
                title: "",
                onBack: () {
                  //controller.dispose();
                  Get.find<WalletController>().getAllBalance();
                  Get.close(3);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
//
// Btn(
// height: 48.h,
// width: Get.width.w,
// color: ColorUtils.primaryColor,
// child: TextUtils.txt(
// text: "Send another Transaction",
// fontSize: 16,
// color: ColorUtils.white),
// onTap: () async {
// try {
// load.value = true;
// await walletController.getSershBalance();
// if (controller.selectedToken.value!.symbol ==
// "SERSH") {
// controller.selectedToken.value =
// walletController.tokens[1];
// } else {
// controller.selectedToken.value =
// walletController.tokens[1];
// }
// load.value = false;
// controller.amount.clear();
// Get.close(2);
// } catch (e) {
// load.value = false;
// ToastUtils.showToast(
// message: "Error Occurred",
// backgroundColor: Colors.red);
// print(e);
// }
// })