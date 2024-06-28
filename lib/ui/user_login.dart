import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/screen_utils.dart';
import '../vm/user_login_controller.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});
  @override
  State<StatefulWidget> createState() => _UserLoginState();

}

class _UserLoginState extends State<UserLogin> {

  late final UserLoginController _controller = Get.put(UserLoginController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      var screenType = getCurrentScreenType(constraints);
      print("Current ScreenType: $screenType");
      return Scaffold(
        appBar: AppBar(
            title: const Text(
              "登录",
              style: TextStyle(fontSize: 22),)
        ),
        body: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 80,left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width.getScaleDownWidth(screenType),
                height: 65,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
                decoration: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 2
                    )
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(hintText: "请输入手机号",border: InputBorder.none,labelStyle: TextStyle(fontSize: 18),hintStyle: TextStyle(fontSize: 18)),
                  controller: _controller.phoneController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40,left: 10,right: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width.getScaleDownWidth(screenType),
                  height: 55,
                  child: ElevatedButton(
                      onPressed: ()=>_controller.login(),
                      child: const Text("登录",style: TextStyle(fontSize: 20),)
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40,left: 10,right: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width.getScaleDownWidth(screenType),
                  height: 55,
                  child: ElevatedButton(
                      onPressed: ()=>_controller.registerAndLogin(),
                      child: const Text("注册并登录",style: TextStyle(fontSize: 20),)
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }


}