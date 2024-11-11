import 'package:get/get.dart';

class Token{
  final String logo;
  final String symbol;
  RxDouble balance;

  Token({required this.logo, required this.symbol, required this.balance});

  // updateBalance(double bal){
  //   balance = bal;
  // }
}