import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import '../bean/token.dart';
import '../dio/DefaultRequestResult.dart';
import '../dio/http_request.dart';

import '../utils/getx_util.dart';
import '../utils/global.dart';
import 'base_controller.dart';


class UserLoginController extends BaseController {
  TextEditingController phoneController = TextEditingController();

  void login(){
    var phone = phoneController.value.text;
    if (phone.isEmpty) {
      EasyLoading.showError("请输入手机号");
      return;
    }  
    HttpRequest().userLogin(
        phone,
        requestResult: DefaultRequestResult(
            success: (data) async {
              var token = Token.fromJson(data as Map<String,dynamic>);
              await Global().setPhone(phone);
              await Global().setToken(token.token ?? "");
              offAllNamed("/home_main");
            },
            emptyData: (){},
            error: (error){
              EasyLoading.showError(error.message);
            }
        ));
  }


  void registerAndLogin(){
    var phone = phoneController.value.text;
    if (phone.isEmpty) {
      EasyLoading.showError("请输入手机号");
      return;
    }
    HttpRequest().registerAndLogin(
        {
          "username":phone,
          "phone":phone
        },
        requestResult: DefaultRequestResult(
            success: (data) async {
              var token = Token.fromJson(data as Map<String,dynamic>);
              await Global().setPhone(phone);
              await Global().setToken(token.token ?? "");
              offAllNamed("/home_main");
            },
            emptyData: (){},
            error: (error){
              EasyLoading.showError(error.message);
            }
        ));
  }

  @override
  void retry() {

  }


}