import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static Future<bool> storeAddress({required String address}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("address", address);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  static Future<String?> getAddress()  async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      final res =pref.getString("address");
      return res;
    }catch(e){
      print(e);
      return null;
    }
  }

  static removeAddress()  async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("address");
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}