import 'package:get/get.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/views/boarding/boarding_one.dart';
import 'package:skey/views/wallet/wallet_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      final res = await Preferences.getAddress();
      if (res != null) {
        Get.offAll(() => WalletScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 1));
      } else {
        Get.offAll(() => const BoardingOne(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 1));
      }
    });
  }
}
