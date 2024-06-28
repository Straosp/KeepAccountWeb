
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keep_account_web/utils/datetime_utils.dart';
import 'package:keep_account_web/utils/getx_util.dart';
import 'package:keep_account_web/utils/screen_utils.dart';
import 'package:keep_account_web/view/dynamic_layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bean/work_records.dart';
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
            child: Text("Keep Account",style: Theme.of(context).textTheme.titleLarge,),),actions: [
              appBarAction(screenType)
          ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5.getScaleUpWidth(screenType)),
                  margin: EdgeInsets.only(left: 5.getScaleUpWidth(screenType),right: 5.getScaleUpWidth(screenType)),
                  child: dynamicLayout(screenType),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.getScaleUpWidth(screenType),right: 20.getScaleUpWidth(screenType)),
                  child: Visibility(
                      visible: screenType == DeviceScreenType.large,
                      maintainAnimation: false,
                      maintainSize: false,
                      maintainState: false,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: LimitedBox(
                                maxHeight: constraints.maxHeight - 500,
                                child: currentMonthWorkRecords(),
                              )
                          ),
                          Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  workRecordsInMonthLineChart(),
                                  workRecordsInYearLineChart(),
                                ],
                              )
                          )
                        ],
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.getScaleUpWidth(screenType)),
                  child: Visibility(
                      visible: screenType != DeviceScreenType.large,
                      maintainAnimation: false,
                      maintainSize: false,
                      maintainState: false,
                      child: workRecordsInMonthLineChart()
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.getScaleUpWidth(screenType)),
                  child: Visibility(
                      visible: screenType != DeviceScreenType.large,
                      maintainAnimation: false,
                      maintainSize: false,
                      maintainState: false,
                      child: workRecordsInYearLineChart()
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.getScaleUpWidth(screenType)),
                  child: Visibility(
                      visible: screenType != DeviceScreenType.large,
                      maintainAnimation: false,
                      maintainSize: false,
                      maintainState: false,
                      child: currentMonthWorkRecords()
                  ),
                ),

              ],
            ),
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
              PopupMenuItem(value: 1,child: Text("添加记录",style: Theme.of(context).textTheme.titleSmall,),),
              PopupMenuItem(value: 2,child: Text("退出登录",style: Theme.of(context).textTheme.titleSmall),),
            ];
          },
          onSelected: (key){
            switch(key){
              case 1:
                showAddWorkRecordsDialog(screenType);
                break;
              case 2:
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


  Widget dynamicLayout(DeviceScreenType screenType){
    if (screenType == DeviceScreenType.large) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 3,child: currentMonthTotalSalary(screenType)),
          Expanded(flex: 7,child: workRecordsInDayLineChart())
        ],
      );
    }else {
      return Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentMonthTotalSalary(screenType),
          workRecordsInDayLineChart()
        ],
      );
    }
  }
  Widget currentMonthTotalSalary(DeviceScreenType screenType){
    return Container(
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
              Text("本月总工资",style: Theme.of(context).textTheme.bodySmall,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text("${_controller.totalDays}",style: Theme.of(context).textTheme.bodyLarge,)),
              Text("本月总工数",style: Theme.of(context).textTheme.bodySmall,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text("${_controller.monthTotalProductQuantity}",style:Theme.of(context).textTheme.bodyLarge,)),
              Text("本月产品总件数",style: Theme.of(context).textTheme.bodySmall,)
            ],
          )
        ],
      ),
    );
  }

  Widget workRecordsInDayLineChart(){
    return Obx((){
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            isVisible: true,
        ),
        selectionType: SelectionType.series,
        zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: false,
            enableSelectionZooming: true,
            zoomMode: ZoomMode.xy,
            enablePanning: true,
            enablePinching: true
        ),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
            alignment: ChartAlignment.far,
            toggleSeriesVisibility: true,
            overflowMode: LegendItemOverflowMode.wrap
        ),
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
            activationMode: ActivationMode.singleTap
        ),
        series: [
          ColumnSeries(
              name: "${getCurrentMonth()}月日工资",
              width: .1,
              color: Theme.of(context).colorScheme.secondary,
              dataSource: _controller.daySalaryEntry.value,
              xValueMapper: (en,_) => en.workDate?.substring(8) ?? "-",
              yValueMapper: (en,_) => en.salary,
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.secondary),
                  labelAlignment: ChartDataLabelAlignment.outer
              )
          )
        ],
      );
    });
  }

  Widget workRecordsInMonthLineChart(){
    return Obx((){
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            isVisible: true
        ),
        selectionType: SelectionType.series,
        zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: false,
            enableSelectionZooming: true,
            zoomMode: ZoomMode.xy,
            enablePanning: true,
            enablePinching: true
        ),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
            alignment: ChartAlignment.far,
            toggleSeriesVisibility: true,
            overflowMode: LegendItemOverflowMode.wrap
        ),
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
            activationMode: ActivationMode.singleTap
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
                  labelAlignment: ChartDataLabelAlignment.outer
              )
          )
        ],
      );
    });
  }

  Widget workRecordsInYearLineChart(){
    return Obx((){
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            isVisible: true
        ),
        selectionType: SelectionType.series,
        zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: false,
            enableSelectionZooming: true,
            zoomMode: ZoomMode.xy,
            enablePanning: true,
            enablePinching: true
        ),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
            alignment: ChartAlignment.far,
            toggleSeriesVisibility: true,
            overflowMode: LegendItemOverflowMode.wrap
        ),
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
            activationMode: ActivationMode.singleTap
        ),
        series: [
          ColumnSeries(
              name: "近5年年工资",
              width: .1,
              color: Theme.of(context).colorScheme.secondary,
              dataSource: _controller.yearSalaryEntry.value,
              xValueMapper: (en,_) => en.workDate,
              yValueMapper: (en,_) => en.salary,
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.secondary),
                  labelAlignment: ChartDataLabelAlignment.outer
              )
          )
        ],
      );
    });
  }

  Widget currentMonthWorkRecords(){
    return Container(
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


  void showAddWorkRecordsDialog(DeviceScreenType screenType) async {
    await showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text("添加新的记录",style: Theme.of(context).textTheme.titleMedium,),
        content: SizedBox(
          height: screenType == DeviceScreenType.small ? 380 :100.getScaleUpWidth(screenType),
          width: screenType == DeviceScreenType.small ? double.infinity : 100.getScaleUpWidth(screenType) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15),
                  child: ListTile(
                    leading: Icon(Icons.calendar_month_rounded,color: Theme.of(context).colorScheme.primary,),
                    title: Obx(() => Text(_controller.workDate.value,style: Theme.of(context).textTheme.bodySmall,)),
                    subtitle: Text("点击可选择时间",style: Theme.of(context).textTheme.bodySmall,),
                    titleAlignment: ListTileTitleAlignment.center,
                    onTap: (){
                      showChooseDateDialog();
                    },
                  )
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
                margin: EdgeInsets.only(top: 20.getScaleUpWidth(screenType),left: 10,right: 10),
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