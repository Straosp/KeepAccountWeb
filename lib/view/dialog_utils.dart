

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showSureDeleteWorkRecord({required BuildContext context,required String date,required Function sureDelete}) async {
  await showDialog(
      context: context,
      builder: (ctx){
        return AlertDialog(
          title: const Text("提示"),
          content: SizedBox(
            width: double.infinity,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("确定要删除在$date的工作记录吗？",style: const TextStyle(fontSize: 18),)
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){Get.back();}, child: const Text("取消",style: TextStyle(fontSize: 18),)),
            TextButton(onPressed: (){
              sureDelete();
              Get.back();
            }, child: const Text("更新",style: TextStyle(fontSize: 18),))
          ],
        );
      }
  );
}