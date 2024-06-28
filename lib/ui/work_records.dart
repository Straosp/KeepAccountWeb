import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../bean/work_records.dart';
import '../utils/getx_util.dart';
import '../utils/widget_util.dart';
import '../vm/work_records_controller.dart';

class WorkRecordsPage extends StatefulWidget {
  const WorkRecordsPage({super.key});

  @override
  State<StatefulWidget> createState() => _WorkRecordsState();
}

class _WorkRecordsState extends State<WorkRecordsPage> {

  late final WorkRecordsController _controller = Get.put(WorkRecordsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("工作记录",style: TextStyle(color: Theme.of(context).colorScheme.primary),),actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: PopupMenuButton<int>(
            offset: const Offset(0,50),
            itemBuilder: (context){
              return <PopupMenuEntry<int>>[
                const PopupMenuItem(value: 1,child: Text("添加新的工作记录"),),
              ];
            },
            onSelected: (index){
              toNamed("/add_work_records");
            },
          ),
        )
      ],),
      body: _controller.obx((state){
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              currentMonthTotalSalary(),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                    itemCount: _controller.workRecords.length,
                    itemExtent: 118,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx,index){
                      return itemView(_controller.workRecords.value[index]);
                    }
                ),
              )
            ],
          ),
        );
      },
          onLoading: loadView(),
          onEmpty: const Center(child: Text("未获取到数据，可点击右上角添加工作记录"),),
          onError: (error){return loadErrorView(_controller.retry);}
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_rounded,size: 30,color: Theme.of(context).colorScheme.secondary,),
        onPressed: (){ _controller.retry(); },
      ),
    );
  }

  Widget currentMonthTotalSalary(){
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text("${_controller.totalSalary}",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w700),)),
                const Text("本月总工资")
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text("${_controller.totalDays}",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w700),)),
                const Text("本月总工数")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemView(WorkRecords data) {
    return InkWell(
        onLongPress: (){
          showUpdateRecordsDialog(data);
        },
        child: Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.workDate ?? "",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${data.productQuantity}",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
                    const Text("产品数量",style: TextStyle(fontSize: 16),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${((data.productQuantity ?? 0) * (data.productPrice ?? 0)) / (data.teamSize ?? 0)}",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
                    const Text("当天工资",style: TextStyle(fontSize: 16),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    )
    );
  }

  void showUpdateRecordsDialog(WorkRecords workRecords) async {
    _controller.productPriceController.text = "${workRecords.productPrice ?? .0}";
    _controller.productQuantityController.text = "${workRecords.productQuantity ?? 0}";
    _controller.teamSizeController.text = "${workRecords.teamSize ?? 0}";
     await showDialog(
         context: context,
         builder: (ctx){
           return AlertDialog(
             shape: const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(10))
             ),
             title: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text("提示"),
                 TextButton(onPressed: (){Get.back();showSureDeleteWorkRecord(workRecords.workDate ?? "",workRecords.id ?? -1); }, child: const Text("删除记录",style: TextStyle(fontSize: 18),)),
               ],
             ),
             titlePadding: const EdgeInsets.only(top: 20,left: 15,right: 10,bottom: 0),
             contentPadding: const EdgeInsets.only(left: 20,right: 20,top: 0),
             content: SizedBox(
               width: double.infinity,
               height: 340,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     margin: const EdgeInsets.only(top: 8,bottom: 2),
                     child: const Text("产品数量",style: TextStyle(fontSize: 18),),
                   ),
                   TextField(
                     textAlign: TextAlign.center,
                     controller: _controller.productQuantityController,
                     style: const TextStyle(fontSize: 20),
                     decoration: InputDecoration(
                         hintText: "请输入产品数量",
                         hintStyle: const TextStyle(fontSize: 20),
                         border: UnderlineInputBorder(
                             borderSide: BorderSide(width: .1,color: Theme.of(context).colorScheme.primary)
                         ),
                     ),
                   ),
                   Container(
                     margin: const EdgeInsets.only(top: 8,bottom: 1),
                     child: const Text("产品单价",style: TextStyle(fontSize: 18),),
                   ),
                   TextField(
                     textAlign: TextAlign.center,
                     controller: _controller.productPriceController,
                     style: const TextStyle(fontSize: 20),
                     decoration: const InputDecoration(
                         hintText: "请输入产品单价",
                         hintStyle: TextStyle(fontSize: 20),
                         border: UnderlineInputBorder()
                     ),
                   ),
                   Container(
                     margin: const EdgeInsets.only(top: 8,bottom: 2),
                     child: const Text("团队人数",style: TextStyle(fontSize: 18),),
                   ),
                   TextField(
                     textAlign: TextAlign.center,
                     controller: _controller.teamSizeController,
                     style: const TextStyle(fontSize: 20),
                     decoration: const InputDecoration(
                         hintText: "请输入团队人数",
                         hintStyle: TextStyle(fontSize: 20),
                         border: UnderlineInputBorder(),
                     ),
                   ),
                 ],
               ),
             ),
             actionsPadding: const EdgeInsets.only(top: 10,bottom: 20,right: 20),
             actions: [
               TextButton(onPressed: (){Get.back();}, child: const Text("取消",style: TextStyle(fontSize: 18),)),
               TextButton(onPressed: (){
                     if (_controller.productQuantityController.value.text.isEmpty) {
                       EasyLoading.showError("请输入产品数量");
                     }else if (_controller.productPriceController.value.text.isEmpty) {
                       EasyLoading.showError("请输入单价");
                     } else if (_controller.teamSizeController.value.text.isEmpty) {
                       EasyLoading.showError("请输入团队人员数量");
                     }else {
                       _controller.updateWorkRecords(workRecords);
                       Get.back();
                     }
                   }, child: const Text("更新",style: TextStyle(fontSize: 18),))
             ],
           );
         });
  }

  void showSureDeleteWorkRecord(String date,int deleteId) async {
      await showDialog(
          context: context,
          builder: (ctx){
            return AlertDialog(
              title: const Text("提示"),
              content: Container(
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
                  _controller.deleteWorkRecords(deleteId);
                  Get.back();
                }, child: const Text("更新",style: TextStyle(fontSize: 18),))
              ],
            );
          }
      );
  }




}