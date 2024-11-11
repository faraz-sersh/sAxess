import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:skey/helpers/helpers.dart';
import 'package:skey/model/token_model.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:web3dart/web3dart.dart';

import '../services/erc-20.dart';
import '../utils/asset_utils.dart';

class WalletController extends GetxController {
  RxDouble balance = (0.0).obs;

  //RxDouble sershBalance = (0.0).obs;
  RxBool load = false.obs;
  RxString address = "".obs;
  RxList<Token> tokens = <Token>[
    Token(logo: AssetUtils.bnbIcon, symbol: "TBNB", balance: (0.0).obs),
    Token(logo: AssetUtils.logoGreen, symbol: "SERSH", balance: (0.0).obs),
  ].obs;


  getBalance() async {
    try {
      load.value = true;

      if (address.value.isNotEmpty) {
        Web3Client client = Web3Client(
            "https://bsc-testnet.nodereal.io/v1/351dc832166e47bbb76426ca5dc45189",
            Client());
        final bal = await client
            .getBalance(EthereumAddress.fromHex(address.value.toLowerCase()));
        print("bal : ${weiToEther(bal.getInWei)}");
        balance.value = weiToEther(bal.getInWei);
        tokens[0].balance = balance;
        load.value = false;
      } else {
        load.value = false;
        ToastUtils.showToast(
            message: "Cannot find address", backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      load.value = false;
      ToastUtils.showToast(
          message: "Error Occurred", backgroundColor: Colors.red);
    }
  }

  getSershBalance() async {
    try {
      load.value = true;

      if (address.value.isNotEmpty) {
        Web3Client client = Web3Client(
            "https://bsc-testnet.nodereal.io/v1/351dc832166e47bbb76426ca5dc45189",
            Client());
        final myaddress = EthereumAddress.fromHex(address.value.toLowerCase());
        final contractAddress = EthereumAddress.fromHex(
            "0xF579C0b725F956eb4D70d2B07af4CA8985AFE39f".toLowerCase());
        ContractAbi cont = ContractAbi.fromJson(jsonEncode(erc20), "sersh");
        final contract = DeployedContract(cont, contractAddress);
        final params = [myaddress];
        final bal = await client.call(
            contract: contract,
            function: contract.function("balanceOf"),
            params: params);
        print(bal);
        tokens[1].balance.value = weiToEther(bal[0]);
        //sershBalance.value = weiToEther(bal[0]);
        load.value = false;
      } else {
        load.value = false;
        ToastUtils.showToast(
            message: "Cannot find address", backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      load.value = false;
      ToastUtils.showToast(
          message: "Error Occurred", backgroundColor: Colors.red);
    }
  }

  getAddress() async {
    address.value = await Preferences.getAddress() ?? "";
  }

  getAllBalance() async {
    await getBalance();
   await  getSershBalance();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getAddress().then((v) {
    getAllBalance();
    });
  }
}
