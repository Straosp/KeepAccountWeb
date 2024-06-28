import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/src/cupertino_localizations.dart';
import 'package:flutter_localizations/src/material_localizations.dart';
import 'package:flutter_localizations/src/widgets_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:keep_account_web/ui/home_main.dart';
import 'package:keep_account_web/ui/splash.dart';
import 'package:keep_account_web/ui/user_login.dart';
import 'package:keep_account_web/view/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '工作记录',
      debugShowCheckedModeBanner: false,
      darkTheme: const MaterialTheme().dark(),
      theme: const MaterialTheme().light(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('zh','CN')
      ],
      home: const Splash(),
      builder: EasyLoading.init(),
      getPages: [
        GetPage(name: "/user_login", page: ()=>const UserLogin()),
        GetPage(name: "/home_main", page:()=> const HomeMain()),
      ],
    );
  }
}
