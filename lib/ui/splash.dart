
import 'package:flutter/material.dart';

import '../utils/getx_util.dart';
import '../utils/global.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() async {
    var token = await Global().getToken();
    if (token.isEmpty) {
      offAllNamed("/user_login");
    }else {
      offAllNamed("/home_main");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Keep Account"),
      ),
    );
  }

}