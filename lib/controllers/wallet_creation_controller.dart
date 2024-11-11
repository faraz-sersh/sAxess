import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class WalletCreationController extends GetxController{

  generateSeed() async {
    var mnemonic = bip39.generateMnemonic();
    String seedHex = bip39.mnemonicToSeedHex(mnemonic);

  }
}