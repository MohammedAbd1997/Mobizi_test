import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();

  static SpHelper spHelper = SpHelper._();
  SharedPreferences? sharedPreferences;

  initSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  setTokenId(String id) {
    sharedPreferences!.setString('Token', id);
  }

  getTokenId() {
    String TokenId = sharedPreferences!.getString('Token') ?? '';
    return TokenId;
  }
}
