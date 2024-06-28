import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class Global{

  static late SharedPreferences _sharedPreferences;

  static Future init() async {

  }

  Future<bool> getIsFirstApp() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(IS_FIRST_APP) ?? true;
  }
  Future<bool> setIsFirstApp(bool b) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setBool(IS_FIRST_APP, b);
  }

  Future<String> getPhone() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(LOGIN_PHONE) ?? "";
  }
  Future<bool> setPhone(String phone) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(LOGIN_PHONE,phone);
  }
  Future<String> getToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(USER_TOKEN) ?? "";
  }
  Future<bool> setToken(String token) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(USER_TOKEN,token);
  }

}