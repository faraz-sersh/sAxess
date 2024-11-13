import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/transaction_controller.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/color_utils.dart';

import 'package:skey/utils/size_utils.dart';
import 'package:skey/views/amount/components/confirm_payment_sheet.dart';
import 'package:skey/widgets/loader.dart';
import 'package:skey/widgets/space_widget.dart';

import '../../utils/text_utils.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/btn_widget.dart';

class AmountScreen extends StatefulWidget {
  AmountScreen({super.key});

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {


  final formKey = GlobalKey<FormState>();

  Rx<Color> textColor = (ColorUtils.sBlack).obs;
  final controller = Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorUtils.darkGrey,
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
                      children: [
                        Space.vertical(120.h),
                        Container(
                          width: 360.w,
                          //height: 185.h,
                          padding: EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Space.vertical(30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AssetUtils.logoGreen,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  Space.horizontal(5.w),
                                  TextUtils.txt(
                                      text: controller.selectedToken.value!.symbol.toUpperCase(),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.textBlackSecondary),
                                  Space.horizontal(10.w),
                                ],
                              ),
                              Space.vertical(20.h),
                              Obx(() {
                                return TextFormField(
                                  controller: controller.amount,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  textAlign: TextAlign.center,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    color: controller.textColor
                                        .value, // Reactive color from controller
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 30.sp,
                                      ),
                                      hintText: "0.00",
                                      errorStyle:
                                          TextStyle(color: ColorUtils.white)),
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (v) {
                                    controller.validateAmountAndUpdateColor(v);
                                    if (controller.amountValid.value) {
                                      return null;
                                    } else {
                                      return "Invalid amount";
                                    }
                                  },
                                );
                              }),
                              Space.vertical(8.h),
                              Obx(() => TextUtils.txt(
                                  text: "Balance: ${controller.balance.value}",
                                  color: ColorUtils.textGreyDark,
                                  fontSize: 12)),
                              Space.vertical(30.h),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() => controller.load.value ? loader() : Btn(
                      height: 48.h,
                      width: Get.width.w,
                      color: ColorUtils.primaryColor,
                      child: TextUtils.txt(
                          text: "Continue",
                          fontSize: 16,
                          color: ColorUtils.white),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          Future.delayed(Duration(milliseconds: 500), (){
                          confirmPaymentSheet(context, controller);
                          });
                        }
                        //Get.to(() => ExistingSeedScreen(), transition: Transition.cupertino);
                      })),
                ),
                const AppBarWidget(title: "Enter Amount"),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
