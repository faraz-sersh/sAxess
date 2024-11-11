import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:skey/main.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/views/boarding/boarding_one.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../helpers/helpers.dart';
import '../services/erc-20.dart';

class TransactionController extends GetxController {
  var textColor = ColorUtils.textBlack.obs;
  var amountValid = true.obs;
  RxDouble balance = (1000.000).obs;

  void validateAmountAndUpdateColor(String? value) {
    Future.delayed(const Duration(milliseconds: 10), () {

      if (value == null || value.trim().isEmpty) {
        balance.value = 1000;
        amountValid.value = true;
        textColor.value = ColorUtils.textBlack;
      } else {
        bool isValidNumber =
            RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(value.trim());
        if (!isValidNumber ||
            (double.tryParse(value.trim()) != null &&
                double.parse(value.trim()) > balance.value)) {
          amountValid.value = false;
          textColor.value = Colors.red;
        } else {
          amountValid.value = true;
          balance.value = 1000 - double.parse(value.trim());
          textColor.value = ColorUtils.textBlack;
        }
      }
    });
  }

  makeTxCoin() async {
    try {
      Web3Client client = Web3Client(
          "https://bsc-testnet.nodereal.io/v1/351dc832166e47bbb76426ca5dc45189",
          Client());
      final address = await Preferences.getAddress();
      if (address != null) {
        final nonce = await client.getTransactionCount(
            EthereumAddress.fromHex(address.toLowerCase()));
        print("nonce : $nonce");
        final gasPrice = await client.getGasPrice();
        print("gasPrice : ${gasPrice.getInWei.toInt()}");
        EtherAmount maxGasPriority = await getMaxPriorityFeePerGas();
        // print("maxGas: ${maxGasPriority.getInWei.toInt()}");
        final gasLimit = await client.estimateGas(
          sender: EthereumAddress.fromHex(address.toLowerCase()),
          to: EthereumAddress.fromHex(
              "0x8e614fD78B7983f416cB3456bD7DAA7A60AC3fE6".toLowerCase()),
          //value: EtherAmount.inWei(BigInt.from(100000000000000000))
        );
        print("gasLimit : ${gasLimit}");

        final res = await iosPlatform.invokeMethod("sendTransaction", {
          "nonce": nonce,
          "to": "0x8e614fD78B7983f416cB3456bD7DAA7A60AC3fE6".toLowerCase(),
          "gasPrice": gasPrice.getInWei.toInt(),
          "gasLimit": gasLimit.toInt(),
          "chainId": "97",
          "bipPath": "m/44'/60'/0'/0/0",
          "value": convertEthToWei(0.01).toInt()
        });
        print(res);
        final tx = await client.sendRawTransaction(hexToBytes(res));
        print(tx);
      } else {
        Get.offAll(() => BoardingOne());
      }
    } catch (e) {
      print(e);
    }
  }

  makeTxToken() async {
    try {
      Web3Client client = Web3Client(
          "https://bsc-testnet.nodereal.io/v1/351dc832166e47bbb76426ca5dc45189",
          Client());
      final address = await Preferences.getAddress();
      if (address != null) {
        ContractAbi cont = ContractAbi.fromJson(jsonEncode(erc20), "serenity");
        final to = EthereumAddress.fromHex(
            "0x8e614fD78B7983f416cB3456bD7DAA7A60AC3fE6".toLowerCase());
        final contractAddress = EthereumAddress.fromHex(
            "0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06".toLowerCase());
        final params = [to, convertEthToWei(0.01)];
        var data;
        cont.functions.forEach((v) {
          if (v.name == "transfer") {
            data = v.encodeCall(params);
          }
        });

        final nonce = await client.getTransactionCount(
            EthereumAddress.fromHex(address.toLowerCase()));
        print("nonce : $nonce");
        final gasPrice = await client.getGasPrice();
        print("gasPrice : ${gasPrice.getInWei.toInt()}");
        final gasLimit = await client.estimateGas(
          sender: EthereumAddress.fromHex(address.toLowerCase()),
          value: EtherAmount.inWei(BigInt.zero),
        );
        print("gasLimit : ${gasLimit}");
        final res = await iosPlatform.invokeMethod("sendTransaction", {
          "nonce": nonce,
          "to": contractAddress.hex,
          "gasPrice": gasPrice.getInWei.toInt(),
          "gasLimit": gasLimit.toInt(),
          "chainId": "97",
          "bipPath": "m/44'/60'/0'/0/0",
          "data": bytesToHex(data),
          "value": convertEthToWei(0).toInt()
        });
        print(res);
        final tx = await client.sendRawTransaction(hexToBytes(res));
        print(tx);
      } else {
        Get.offAll(() => BoardingOne());
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<EtherAmount> getMaxPriorityFeePerGas() {
    return Future.value(EtherAmount.inWei(BigInt.from(1000000000)));
  }

  static Future<EtherAmount> getMaxFeePerGas(
    Web3Client client,
    BigInt maxPriorityFeePerGas,
  ) async {
    final blockInformation = await client.getBlockInformation();
    final baseFeePerGas = blockInformation.baseFeePerGas;

    if (baseFeePerGas == null) {
      return EtherAmount.zero();
    }

    return EtherAmount.inWei(
      baseFeePerGas.getInWei * BigInt.from(2) + maxPriorityFeePerGas,
    );
  }
}
