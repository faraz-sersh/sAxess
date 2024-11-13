import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skey/utils/asset_utils.dart';
import 'package:skey/widgets/space_widget.dart';

class FirstAnimatedRow extends StatefulWidget {
  const FirstAnimatedRow({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  State<FirstAnimatedRow> createState() => _FirstAnimatedRowState();
}

class _FirstAnimatedRowState extends State<FirstAnimatedRow> {
  late Animation<Offset> rowAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rowAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.linear,
    ));
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return SlideTransition(
          position: rowAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(AssetUtils.btcIcon, width: 50.w, height: 50.h,),
              Space.horizontal(30.w),
              SvgPicture.asset(AssetUtils.ethIcon, width: 50.w, height: 50.h,),
              Space.horizontal(30.w),
              SvgPicture.asset(AssetUtils.usdtIcon, width: 50.w, height: 50.h,),
              Space.horizontal(30.w),
              SvgPicture.asset(
                AssetUtils.maticIcon, width: 50.w, height: 50.h,),
              Space.horizontal(30.w),
              SvgPicture.asset(AssetUtils.nearIcon, width: 50.w, height: 50.h,),
              Space.horizontal(20.w),

            ],
          ),
        );
      },
    );
  }
}
