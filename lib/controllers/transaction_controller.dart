import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:skey/main.dart';
import 'package:skey/services/preferences.dart';
import 'package:skey/views/boarding/boarding_one.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../services/erc-20.dart';

class TransactionController extends GetxController {
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
        final params = [to, BigInt.from(10000000000)];
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
        // Transaction transaction = Transaction(
        //     to: contractAddress,
        //     value: EtherAmount.zero(),
        //     maxGas: gasLimit.toInt(),
        //     data: data,
        //     gasPrice: gasPrice,
        //     nonce: nonce);
        //final serial = transaction.getUnsignedSerialized(chainId: 97);
        //print("serial : ${bytesToHex(serial)}");
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

  static BigInt convertEthToWei(double eth) {
    // 1 ETH = 10^18 Wei
    const int weiPerEth = 1000000000000000000;
    return BigInt.from((eth * weiPerEth).toInt());
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
