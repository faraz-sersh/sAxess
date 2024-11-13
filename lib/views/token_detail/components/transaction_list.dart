import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skey/utils/text_utils.dart';

import '../../../utils/color_utils.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 360.w,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: ColorUtils.white),
        child: TextUtils.txt(
            text: "You don't have any transactions yet", fontSize: 16));
  }
}
