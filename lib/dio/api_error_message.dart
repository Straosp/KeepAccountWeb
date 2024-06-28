import 'dart:collection';

import '../bean/ErrorMessage.dart';
import 'app_url.dart';

class ApiErrorMessage{

  final int _API_CODE_PREFIX = 100;

  HashMap<String,int> hashMap  = HashMap();
  ApiErrorMessage(){
    hashMap.clear();
    hashMap[AppUrl.login] = 1 * _API_CODE_PREFIX;
    hashMap[AppUrl.getAllUser] = 2 * _API_CODE_PREFIX;
    hashMap[AppUrl.register] = 3 * _API_CODE_PREFIX;
  }
  int getApiCode(String api) => (hashMap[api] ?? 100) ~/ 100;
  ErrorMessage getApiErrorCode(int code,String apiPath,String? message) => ErrorMessage((hashMap[apiPath] ?? 100) + code, message ?? "网络连接失败，请连接网络后重试");

}