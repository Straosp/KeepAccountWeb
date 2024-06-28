import 'package:get/get.dart';
import 'package:flutter/material.dart';

void toPage(Widget page,{Map? arguments}){
  Get.to(()=> page,arguments: arguments,transition: Transition.rightToLeftWithFade);
}
void offPage(Widget page,Map? arguments){
  Get.offAll(() => page,arguments: arguments,transition: Transition.rightToLeftWithFade);
}
void toNamed(String page, {dynamic arguments, preventDuplicates = false}) {
  Get.toNamed(page, preventDuplicates: preventDuplicates, arguments: arguments);
}
void offNamed(String page, dynamic arguments, {preventDuplicates = false}) {
  Get.offNamed(page,
      preventDuplicates: preventDuplicates, arguments: arguments);
}
void offAllNamed(String page, {dynamic arguments}) {
  Get.offAllNamed(page, arguments: arguments);
}

void offAndToNamed(String page, {dynamic arguments}) {
  Get.offAndToNamed(page, arguments: arguments);
}