
import 'package:flutter/material.dart';

Widget loadView(){
  return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 200,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("正在加载...."),
            )
          ],
        ),
      )
  );
}
Widget loadErrorView(Function retry){
  return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15,bottom: 10,top: 15),
              child: const Text("网络请求失败，请检查网络稍后重试",style: TextStyle(fontSize: 16),),
            ),
            ElevatedButton(onPressed: ()=>retry(), child: const Text("点击重试")),
          ],
        ),
      )
  );
}

Widget iconTitle({required String title, String? hint,bool isShowEndPoint = true,required Function onClick}){

  return InkWell(
    onTap: (){
      onClick();
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: const TextStyle(fontSize: 18),),
          const Spacer(),
          Visibility(
              visible: hint != null && hint.isNotEmpty,
              maintainAnimation: false,
              maintainSize: false,
              maintainState: false,
              child: Text(hint ?? "",style: const TextStyle(fontSize: 10),)
          ),
          Visibility(
              visible: isShowEndPoint,
              maintainAnimation: false,
              maintainSize: false,
              maintainState: false,
              child: const Icon(Icons.chevron_right_rounded,size: 20,color: Colors.blue,)
          ),
        ],
      ),
    ),
  );

}
