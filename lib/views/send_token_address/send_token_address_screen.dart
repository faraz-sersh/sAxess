import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skey/controllers/pop_up_controller.dart';
import 'package:skey/controllers/transaction_controller.dart';
import 'package:skey/model/token_model.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/utils/size_utils.dart';
import 'package:skey/utils/text_utils.dart';
import 'package:skey/views/amount/amount_screen.dart';
import 'package:skey/widgets/btn_widget.dart';
import 'package:skey/widgets/space_widget.dart';
import 'package:web3dart/credentials.dart';

import '../../utils/color_utils.dart';

class SendTokenAddressScreen extends StatefulWidget {
  SendTokenAddressScreen({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  State<SendTokenAddressScreen> createState() => _SendTokenAddressScreenState();
}

class _SendTokenAddressScreenState extends State<SendTokenAddressScreen> {
  final formKey = GlobalKey<FormState>();

  bool isValidEmailAddreess(String v) {
    try {
      EthereumAddress.fromHex(v);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    controller.setToken(widget.token);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextUtils.txt(text: "${widget.token.symbol}", fontSize: 20),
          elevation: 0.0,
          centerTitle: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: SizedBox(
          width: SizeUtils.width.w,
          height: SizeUtils.height.h,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space.vertical(40.h),
                    Center(
                        child: SvgPicture.asset(
                      AssetUtils.sAxessLogo,
                      height: 50.h,
                      width: 50.w,
                      color: ColorUtils.primaryColor,
                    )),
                    // Space.vertical(20.h),
                    // TextUtils.txt(
                    //     text: "Enjoy seamless transactions with sAxess.",
                    //     fontSize: 20),
                    Space.vertical(50.h),
                    TextUtils.txt(
                        text: "Enter Receiver Address",
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    Space.vertical(10.h),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorUtils.grey,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.addressCont,
                          validator: (v) {
                            if (v!.trim().isEmpty) {
                              return "Please enter address";
                            } else if (!isValidEmailAddreess(v.toLowerCase())) {
                              return "Invalid Address";
                            }
                          },
                          style:
                              TextStyle(fontFamily: "Outfit", fontSize: 16.sp),
                          cursorColor: ColorUtils.textBlack,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12.w),
                              border: InputBorder.none,
                              hintText: "0x1234....................7890",
                              hintStyle: TextStyle(
                                  fontFamily: "Outfit",
                                  fontSize: 14.sp,
                                  color: ColorUtils.textGreyDark)),
                        ),
                      ),
                    ),
                    Space.vertical(30.h),
                    Btn(
                        height: 50.h,
                        width: Get.width.w,
                        color: ColorUtils.primaryColor,
                        child: TextUtils.txt(
                            text: "Continue", color: ColorUtils.white),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Get.to(() => AmountScreen(),
                                transition: Transition.cupertino);
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
