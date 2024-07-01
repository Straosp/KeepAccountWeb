
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keep_account_web/bean/salary_records.dart';
import 'package:keep_account_web/utils/datetime_utils.dart';
import 'package:keep_account_web/utils/getx_util.dart';
import 'package:keep_account_web/utils/screen_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bean/work_records.dart';
import '../view/dialog_utils.dart';
import '../vm/work_records_controller.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});


  @override
  State<StatefulWidget> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with SingleTickerProviderStateMixin{

  late final WorkRecordsController _controller = Get.put(WorkRecordsController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      var screenType = getCurrentScreenType(constraints);
      return Scaffold(
          appBar: AppBar(
            title: Container(
            margin: EdgeInsets.only(left: 50.getScaleUpWidth(screenType)),
            alignment: Alignment.centerLeft,
            child: Text("工作记录",style: Theme.of(context).textTheme.titleLarge,),),actions: [
              appBarAction(screenType)
          ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.getScaleUpWidth(screenType)),
            child: screenType == DeviceScreenType.large ? largeWidget() : middleSmallWidget(),
          )
      );
    });
  }

  Widget appBarAction(DeviceScreenType screenType){
    if (screenType == DeviceScreenType.small) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: PopupMenuButton<int>(
          offset: const Offset(0,50),
          itemBuilder: (context){
            return <PopupMenuEntry<int>>[
              PopupMenuItem(value: 1,child: Text("历史记录",style: Theme.of(context).textTheme.titleSmall,),),
              PopupMenuItem(value: 2,child: Text("添加记录",style: Theme.of(context).textTheme.titleSmall,),),
              PopupMenuItem(value: 3,child: Text("退出登录",style: Theme.of(context).textTheme.titleSmall),),
            ];
          },
          onSelected: (key){
            switch(key){
              case 1:
                toNamed("/work_records_history");
              case 2:
                showAddWorkRecordsDialog(screenType);
                break;
              case 3:
                offAllNamed("/user_login");
                break;
            }
          },
        ),
      );
    }else {
      return Container(
        margin: EdgeInsets.only(right: 50.0.getScaleUpWidth(screenType)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.getScaleUpWidth(screenType)),
              child: InkWell(
                onTapDown: (d){
                  toNamed("/work_records_history");
                },
                child: const Text("历史记录",style: TextStyle(fontSize: 16),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.getScaleUpWidth(screenType)),
              child: InkWell(
                onTapDown: (d){
                  showAddWorkRecordsDialog(screenType);
                },
                child: const Text("添加记录",style: TextStyle(fontSize: 16),),
              ),
            ),
            InkWell(
              onTapDown: (d){
                offAllNamed("/user_login");
              },
              child: const Text("退出登录",style: TextStyle(fontSize: 16),),
            )
          ],
        ),
      );
    }
  }

  Widget largeWidget(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            currentMonthTotalSalary(DeviceScreenType.large),
            workRecordsInMonthLineChart()
          ],
        )),
        SizedBox(width: 10.getScaleUpWidth(DeviceScreenType.large),),
        Obx(() => Visibility(
            maintainAnimation: false,
            maintainSize: false,
            maintainState: false,
            child: Expanded(child: currentMonthWorkRecordsLiveView())
        )),
        Obx(() => Visibility(
            visible: _controller.workRecords.isEmpty,
            maintainAnimation: false,
            maintainSize: false,
            maintainState: false,
            child: const Expanded(child: SelectableText("本月没有上班哦")))),
        SizedBox(width: 10.getScaleUpWidth(DeviceScreenType.large),),
      ],
    );
  }

  Widget middleSmallWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        currentMonthTotalSalary(DeviceScreenType.large),
        workRecordsInMonthLineChart(),
        currentMonthWorkRecordsLiveView(),
        Obx(() => Visibility(
            visible: _controller.workRecords.isEmpty,
            maintainAnimation: false,
            maintainSize: false,
            maintainState: false,
            child: Container(
              margin: EdgeInsets.only(top: 50.getScaleUpWidth(DeviceScreenType.small)),
              child: const SelectableText("本月没有上班哦"),
            ))),
      ],
    );
  }

  Widget currentMonthWorkRecordsLiveView(){
    return ListView.builder(
        itemCount: _controller.workRecords.length,
        itemExtent: 118,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx,index){
          return workRecordsItemView(_controller.workRecords.value[index]);
        }
    );
  }
  Widget workRecordsItemView(WorkRecords data) {
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
  Widget currentMonthTotalSalary(DeviceScreenType screenType){
    return Container(
      padding: EdgeInsets.only(top: 5.getScaleUpWidth(screenType),bottom: 5.getScaleUpWidth(screenType)),
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
              Obx(() => SelectableText("${_controller.totalSalary}",style: Theme.of(context).textTheme.bodyLarge,)),
              Text("本月总工资",style: Theme.of(context).textTheme.titleSmall,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => SelectableText("${_controller.totalDays}",style: Theme.of(context).textTheme.bodyLarge,)),
              Text("本月总工数",style: Theme.of(context).textTheme.titleSmall,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => SelectableText("${_controller.monthTotalProductQuantity}",style:Theme.of(context).textTheme.bodyLarge,)),
              Text("本月产品总件数",style: Theme.of(context).textTheme.titleSmall,),
              Obx(() => Visibility(
                  visible: _controller.singleWorkProductQuantity.value > 0,
                  maintainAnimation: false,
                  maintainSize: false,
                  maintainState: false,
                  child: SelectableText("含个人件${_controller.singleWorkProductQuantity.value}件",style: Theme.of(context).textTheme.headlineSmall,)
              ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => SelectableText("${_controller.totalYearSalary.value}",style:Theme.of(context).textTheme.bodyLarge,)),
              Text("本年度总工资",style: Theme.of(context).textTheme.titleSmall,)
            ],
          )
        ],
      ),
    );
  }
  Widget workRecordsInMonthLineChart(){
    return Obx((){
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            isVisible: true
        ),
        onChartTouchInteractionUp: null,
        selectionType: SelectionType.series,
        trackballBehavior: TrackballBehavior(
            lineType: TrackballLineType.vertical,
            enable: true,
            tooltipSettings: const InteractiveTooltip(
                color: Colors.purple,
                connectorLineColor: Colors.yellow
            ),
            tooltipAlignment: ChartAlignment.center,
            shouldAlwaysShow: true,
            tooltipDisplayMode: TrackballDisplayMode.floatAllPoints
        ),
        tooltipBehavior: TooltipBehavior(
            enable: true,
            shared: true,
            borderColor: Theme.of(context).colorScheme.onBackground,
            activationMode: ActivationMode.singleTap,
            builder: (data, point, series, pointIndex, seriesIndex){
              return toolTitle(data);
            }
        ),
        series: [
          ColumnSeries(
              name: "${getCurrentYear()}年月工资",
              width: .1,
              color: Theme.of(context).colorScheme.secondary,
              dataSource: _controller.monthSalaryEntry.value,
              xValueMapper: (en,_) => en.workDate?.substring(5) ?? "-",
              yValueMapper: (en,_) => en.salary,
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.secondary),
                labelAlignment: ChartDataLabelAlignment.outer,
              )
          )
        ],
      );
    });
  }

  Widget toolTitle(SalaryRecords salaryRecords){
    return Container(
      width: 120,
      height: 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(salaryRecords.workDate ?? "",style:  const TextStyle(fontSize: 14),),
          Text("工资：${salaryRecords.salary}",style:  const TextStyle(fontSize: 14)),
          Text("数量：${salaryRecords.monthQuantity}",style:  const TextStyle(fontSize: 14)),
          Visibility(
            visible: (salaryRecords.singleWorkProductQuantity ?? 0) > 0,
            maintainAnimation: false,
            maintainSize: false,
            maintainState: false,
            child: Text("个人件数: ${salaryRecords.singleWorkProductQuantity}",style: const TextStyle(fontSize: 12),)
          )
        ],
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
                TextButton(
                    onPressed: (){
                      Get.back();
                      showSureDeleteWorkRecord(
                          context: context,
                          date: workRecords.workDate ?? "",
                          sureDelete: (){
                            _controller.deleteWorkRecords(workRecords.id ?? 0);
                          });
                    },
                    child: const Text("删除记录",style: TextStyle(fontSize: 18),)
                ),
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
  void showAddWorkRecordsDialog(DeviceScreenType screenType) async {
    await showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text("添加新的记录",style: Theme.of(context).textTheme.titleSmall,),
        content: SizedBox(
          height: 400,
          width: screenType == DeviceScreenType.small ? double.infinity : 120.getScaleUpWidth(screenType) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.calendar_month_rounded,color: Theme.of(context).colorScheme.primary,),
                title: Obx(() => Text(_controller.workDate.value,style: Theme.of(context).textTheme.bodySmall,)),
                subtitle: Text("点击可选择时间",style: Theme.of(context).textTheme.bodySmall,),
                titleAlignment: ListTileTitleAlignment.center,
                onTap: (){
                  showChooseDateDialog();
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20,left: 15,right: 15),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller.addWorkRecordsProductQuantityController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                      labelText: "产品数量",
                      hintText: "请输入产品数量",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(width: .1,color: Theme.of(context).colorScheme.primary)
                      ),
                      labelStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller.addWorkRecordsProductPriceController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                      labelText: "产品单价",
                      hintText: "请输入产品单价",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: const UnderlineInputBorder(),
                      labelStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller.addWorkRecordsTeamSizeController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                      labelText: "团队人数",
                      hintText: "请输入团队人数",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: const UnderlineInputBorder(),
                      labelStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: (){_controller.submitWorkRecord();},
                      child: Text("提交工作记录",style: Theme.of(context).textTheme.bodySmall,)
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
  void showChooseDateDialog() async {
    var time = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (time != null){
      _controller.workDate.value = "${time.year.toString()}-${time.month.toString().padLeft(2,'0')}-${time.day.toString().padLeft(2,'0')}";
    }

  }


}