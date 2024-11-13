import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:skey/controllers/wallet_controller.dart';
import 'package:skey/main.dart';
import 'package:skey/model/token_model.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/utils/color_utils.dart';
import 'package:skey/utils/toast_utils.dart';
import 'package:skey/views/boarding/boarding_one.dart';
import 'package:skey/views/payment_successfull/payment_succesfull_screen.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../helpers/helpers.dart';
import '../services/erc-20.dart';

class TransactionController extends GetxController {
  var textColor = ColorUtils.textBlack.obs;
  var amountValid = true.obs;
  RxDouble balance = (0.0).obs;
  RxString transactionId = "".obs;
  Rx<Token?> selectedToken = Rx<Token?>(null);
  TextEditingController addressCont = TextEditingController();
  TextEditingController amount = TextEditingController();
  RxBool load = false.obs;
  final walletController = Get.find<WalletController>();

  setToken(Token token) {
    selectedToken.value = token;
    balance.value = token.balance.value;
  }

  void validateAmountAndUpdateColor(String? value) {
    Future.delayed(const Duration(milliseconds: 10), () {
      if (value == null || value.trim().isEmpty) {
        balance.value = selectedToken.value!.balance.value;
        amountValid.value = true;
        textColor.value = ColorUtils.textBlack;
      } else {
        bool isValidNumber =
            RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(value.trim());
        if (!isValidNumber ||
            (double.tryParse(value.trim()) != null &&
                double.parse(value.trim()) >
                    selectedToken.value!.balance.value)) {
          amountValid.value = false;
          textColor.value = Colors.red;
        } else {
          amountValid.value = true;
          balance.value =
              selectedToken.value!.balance.value - double.parse(value.trim());
          textColor.value = ColorUtils.textBlack;
        }
      }
    });
  }

  makeTxToken(
    context,
  ) async {
    try {
      load.value = true;
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
          to: EthereumAddress.fromHex(addressCont.text.trim().toLowerCase()),
          //value: EtherAmount.inWei(BigInt.from(100000000000000000))
        );
        print("gasLimit : $gasLimit");
        //load.value = false;

        final res = await iosPlatform.invokeMethod("sendTransaction", {
          "nonce": nonce,
          "to": addressCont.text.trim().toLowerCase(),
          "gasPrice": gasPrice.getInWei.toInt(),
          "gasLimit": gasLimit.toInt(),
          "chainId": "97",
          "bipPath": "m/44'/60'/0'/0/0",
          "value": convertEthToWei(double.parse(amount.text.trim())).toInt()
        });
        print(res);
        final tx = await client.sendRawTransaction(hexToBytes(res));
        print(tx);
        transactionId.value = tx;
        Get.back();
        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(context).unfocus();
        });
        Future.delayed(const Duration(milliseconds: 1500), () async {
          final status = await waitForTransactionToBeMinedWithTimeout(
              client, transactionId.value);
          if (status) {
            await walletController.getAllBalance();
            if (selectedToken.value!.symbol == "SERSH") {
              setToken(walletController.tokens[1]);
            } else {
              setToken(walletController.tokens[0]);
            }
            load.value = false;
            Get.to(() => PaymentSuccesfullScreen(),
                transition: Transition.cupertino);
          } else {
            await walletController.getAllBalance();
            load.value = false;
            ToastUtils.showToast(message: "Error Occurred!");
          }
        });
      } else {
        Get.offAll(() => const BoardingOne());
      }
    } catch (e) {
      load.value = false;
      ToastUtils.showToast(message: "Error Occurred!");
      print(e);
    }
  }

  makeTxCoin(
    context,
  ) async {
    try {
      load.value = true;
      Web3Client client = Web3Client(
          "https://bsc-testnet.nodereal.io/v1/351dc832166e47bbb76426ca5dc45189",
          Client());
      final address = await Preferences.getAddress();
      if (address != null) {
        ContractAbi cont = ContractAbi.fromJson(jsonEncode(erc20), "serenity");
        final to =
            EthereumAddress.fromHex(addressCont.text.trim().toLowerCase());
        final contractAddress = EthereumAddress.fromHex(
            "0xF579C0b725F956eb4D70d2B07af4CA8985AFE39f".toLowerCase());
        final params = [to, convertEthToWei(double.parse(amount.text.trim()))];
        var data;
        for (var v in cont.functions) {
          if (v.name == "transfer") {
            data = v.encodeCall(params);
          }
        }

        final nonce = await client.getTransactionCount(
            EthereumAddress.fromHex(address.toLowerCase()));
        print("nonce : $nonce");
        final gasPrice = await client.getGasPrice();
        print("gasPrice : ${gasPrice.getInWei.toInt()}");
        final gasLimit = await client.estimateGas(
          sender: EthereumAddress.fromHex(address.toLowerCase()),
          value: EtherAmount.inWei(BigInt.zero),
        );
        print("gasLimit : $gasLimit");

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
        transactionId.value = tx;
        Get.back();
        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(context).unfocus();
        });
        Future.delayed(const Duration(milliseconds: 1500), () async {
          final status = await waitForTransactionToBeMinedWithTimeout(
              client, transactionId.value);
          if (status) {
            await walletController.getAllBalance();
            if (selectedToken.value!.symbol == "SERSH") {
              setToken(walletController.tokens[1]);
            } else {
              setToken(walletController.tokens[0]);
            }
            load.value = false;
            Get.to(() => PaymentSuccesfullScreen(),
                transition: Transition.cupertino);
          } else {
            await walletController.getAllBalance();
            load.value = false;
            ToastUtils.showToast(message: "Error Occurred!");
          }
        });
      } else {
        Get.offAll(() => const BoardingOne());
      }
    } catch (e) {
      load.value = false;
      ToastUtils.showToast(message: "Error Occurred!");
      print(e);
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

  Future<bool> waitForTransactionToBeMinedWithTimeout(
      Web3Client client, String transactionHash,
      {int intervalSeconds = 2, int maxRetries = 5}) async {
    try {
      print('Waiting for transaction to be mined...');

      bool isMined = false;
      int retries = 0;

      while (!isMined && retries < maxRetries) {
        // Check the transaction status
        final transaction = await client.getTransactionByHash(transactionHash);

        if (transaction == null) {
          // If the transaction is not found, it may still be pending.
          print('Transaction not found yet...');
        } else if (!transaction.blockNumber.isPending) {
          // If the transaction has a block number, it is mined.
          isMined = true;
          print('Transaction mined in block: ${transaction.blockNumber}');
        } else {
          // If the transaction is not mined yet, continue checking.
          print('Transaction is still pending...');
        }

        // Wait for the next polling interval
        if (!isMined) {
          await Future.delayed(Duration(seconds: intervalSeconds));
          retries++;
        }
      }

      return isMined;
    } catch (e) {
      print('Error checking transaction status: $e');
      return false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    addressCont.dispose();
    amount.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addressCont.clear();
    amount.clear();
  }
}
