import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:keep_account_web/utils/screen_utils.dart';
import 'package:keep_account_web/vm/work_records_history_controller.dart';

import '../bean/work_records.dart';

class WorkRecordsHistory extends StatefulWidget {
  const WorkRecordsHistory({super.key});


  @override
  State<StatefulWidget> createState() => _WorkRecordsHistoryState();

}

class _WorkRecordsHistoryState extends State<WorkRecordsHistory> {

  late final WorkRecordsHistoryController _controller = Get.put(WorkRecordsHistoryController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      var screenType = getCurrentScreenType(constraints);
      return Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){ Get.back();},icon: const Icon(Icons.arrow_back_rounded),),title: const Text("历史记录"),),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){_controller.lastMonth();}, icon: const Icon(Icons.arrow_back_ios_rounded)),
                  Obx(() => Text("${_controller.year.value}-${_controller.month.value.toString().padLeft(2,"0")}")),
                  IconButton(onPressed: (){_controller.nextMonth();}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
              Obx(() => Visibility(
                  visible: _controller.workRecords.isNotEmpty,
                  maintainAnimation: false,
                  maintainSize: false,
                  maintainState: false,
                  child: Container(
                    margin: EdgeInsets.only(top: 20.getScaleUpWidth(screenType)),
                    padding: EdgeInsets.only(top: 10.getScaleUpWidth(screenType),bottom: 10.getScaleUpWidth(screenType)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
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
                            Obx(() => Text("${_controller.totalSalary}",style: Theme.of(context).textTheme.bodyLarge,)),
                            Text("本月总工资",style: Theme.of(context).textTheme.titleSmall,)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text("${_controller.totalDays}",style: Theme.of(context).textTheme.bodyLarge,)),
                            Text("本月总工数",style: Theme.of(context).textTheme.titleSmall,)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text("${_controller.monthTotalProductQuantity}",style:Theme.of(context).textTheme.bodyLarge,)),
                            Text("本月产品总件数",style: Theme.of(context).textTheme.titleSmall,),
                            Obx(() => Visibility(
                                visible: _controller.singleWorkProductQuantity.value > 0,
                                maintainAnimation: false,
                                maintainSize: false,
                                maintainState: false,
                                child: Text("含个人件${_controller.singleWorkProductQuantity.value}件",style: Theme.of(context).textTheme.headlineSmall,)
                            ))
                          ],
                        )
                      ],
                    ),
                  )
              )),
              Obx(() => Visibility(
                  visible: _controller.workRecords.isEmpty,
                  maintainAnimation: false,
                  maintainSize: false,
                  maintainState: false,
                  child: Container(
                    margin: EdgeInsets.only(top: 50.getScaleUpWidth(screenType)),
                    child: const SelectableText("本月没有上班哦"),
                  ))),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Obx(() => ListView.builder(
                    itemCount: _controller.workRecords.length,
                    itemExtent: 118,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx,index){
                      return itemView(_controller.workRecords.value[index]);
                    }
                )),
              )
            ],
          ),
        ),
      );
    });

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
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(15)
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
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${(data.productQuantity ?? 0) / (data.teamSize ?? 0)}",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
                      const Text("当日产量",style: TextStyle(fontSize: 16),)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
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