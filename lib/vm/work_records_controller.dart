
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../bean/SalaryRecords.dart';
import '../bean/work_records.dart';
import '../dio/DefaultRequestResult.dart';
import '../dio/http_request.dart';
import '../utils/datetime_utils.dart';
import 'base_controller.dart';

class WorkRecordsController extends BaseController {

  var totalSalary = .0.obs;
  var totalDays = 0.obs;
  var monthTotalProductQuantity = .0.obs;

  var workRecords = <WorkRecords>[].obs;
  var productQuantityController = TextEditingController();
  var productPriceController = TextEditingController();
  var teamSizeController = TextEditingController();

  var daySalaryEntry = <SalaryRecords>[].obs;
  var monthSalaryEntry = <SalaryRecords>[].obs;
  var yearSalaryEntry = <SalaryRecords>[].obs;

  var addWorkRecordsProductQuantityController = TextEditingController();
  var addWorkRecordsProductPriceController = TextEditingController();
  var addWorkRecordsTeamSizeController = TextEditingController();

  var workDate = "".obs;


  @override
  void onReady() {
    super.onReady();
    workDate.value = "${getCurrentYear()}-${getCurrentMonth().toString().padLeft(2,"0")}-${getCurrentDay().toString().padLeft(2,"0")}";
    getCurrentMonthRecords();
    _getWorkRecordsByDay();
    _getWorkRecordsByMonth();
    _getWorkRecordsByYear();
  }

  @override
  void retry() {
    getCurrentMonthRecords();
  }
  void getCurrentMonthRecords(){
    HttpRequest().getCurrentMonthWorkRecords(
        requestResult: DefaultRequestResult(
            success: (data){
              totalSalary.value = .0;
              monthTotalProductQuantity.value = .0;
              var result = (data as List<dynamic>).map((e) => WorkRecords.fromJson(e as Map<String,dynamic>)).toList();
              var salaryMap = <int,double>{};
              for (var element in result) {
                var last = salaryMap[element.teamSize] ?? 0;
                salaryMap[element.teamSize ?? 0] = last + ((element.productPrice ?? 0) * (element.productQuantity ?? 0));
                monthTotalProductQuantity.value += (element.productQuantity ?? 0) / (element.teamSize ?? 0);
              }
              for (var element in salaryMap.keys) {
                totalSalary.value += ((salaryMap[element] ?? 0) / element);
              }
              totalDays.value = result.length;
              workRecords.clear();
              workRecords.addAll(result);
              change(null,status: RxStatus.success());
            },
            emptyData: (){
              change(null,status: RxStatus.empty());
            },
            error: (error){
              EasyLoading.showError(error.message);
              change(null,status: RxStatus.error(error.message));
            }
        ));
  }

  void updateWorkRecords(WorkRecords data){
    HttpRequest().updateWorkRecords(
    data.copyWith(
        productQuantity: int.tryParse(productQuantityController.value.text),
        productPrice: double.tryParse(productPriceController.value.text),
        teamSize: int.tryParse(teamSizeController.value.text)
    ),
    requestResult: BoolRequestResult(
        success: (){
          EasyLoading.showSuccess("更新成功");
          getCurrentMonthRecords();
        }, 
        error: (error){
          EasyLoading.showError(error.message);
        }
    ));
  }

  void deleteWorkRecords(int id){
    HttpRequest().deleteWorkRecordsById(
        id,
        requestResult: BoolRequestResult(
            success: (){
              EasyLoading.showSuccess("删除成功");
              retry();
            },
            error: (error){
              EasyLoading.showError(error.message);
            }
        ));
  }

  void _getWorkRecordsByYear(){
    HttpRequest().getWorkRecordsRangeYear(
        {
          "startDate": (getCurrentYear() - 5).toString(),
          "endDate": getCurrentYear().toString()
        },
        requestResult: DefaultRequestResult(
            success: (data){
              yearSalaryEntry.clear();
              yearSalaryEntry.addAll( (data as List<dynamic>).map((e) => SalaryRecords.fromJson(e as Map<String,dynamic>)).toList() );
              change(null,status: RxStatus.success());
            },
            emptyData: (){
              yearSalaryEntry.clear();
              change(null,status: RxStatus.success());
            },
            error: (error){
              EasyLoading.showError(error.message);
              change(null,status: RxStatus.empty());
            }
        ));
  }
  void _getWorkRecordsByMonth(){
    HttpRequest().getWorkRecordsRangeMonth(
        {
          "startDate": "${getCurrentYear()}-01",
          "endDate": "${getCurrentYear()}-12"
        },
        requestResult: DefaultRequestResult(
            success: (data){
              monthSalaryEntry.clear();
              monthSalaryEntry.addAll( (data as List<dynamic>).map((e) => SalaryRecords.fromJson(e as Map<String,dynamic>)).toList() );
              change(null,status: RxStatus.success());
            },
            emptyData: (){
              monthSalaryEntry.clear();
              change(null,status: RxStatus.success());
            },
            error: (error){
              EasyLoading.showError(error.message);
              change(null,status: RxStatus.empty());
            }
        ));
  }
  void _getWorkRecordsByDay(){
    var startDate = "${getCurrentYear()}-${getCurrentMonth().toString().padLeft(2,"0")}-01";
    var endDate = "${getCurrentYear()}-${getCurrentMonth().toString().padLeft(2,"0")}-${getDaysInMonth(getCurrentYear(), getCurrentMonth())}";
    HttpRequest().getWorkRecordsRangeDay(
        {
          "startDate": startDate,
          "endDate": endDate
        },
        requestResult: DefaultRequestResult(
            success: (data){
              daySalaryEntry.clear();
              daySalaryEntry.addAll( (data as List<dynamic>).map((e) => SalaryRecords.fromJson(e as Map<String,dynamic>)).toList() );
              change(null,status: RxStatus.success());
            },
            emptyData: (){
              daySalaryEntry.clear();
              change(null,status: RxStatus.success());
            },
            error: (error){
              EasyLoading.showError(error.message);
              change(null,status: RxStatus.empty());
            }
        ));
  }

  void submitWorkRecord(){
    if (addWorkRecordsProductQuantityController.value.text.isEmpty) {
      EasyLoading.showError("请输入数量");
      return;
    }
    if (addWorkRecordsProductPriceController.value.text.isEmpty) {
      EasyLoading.showError("请输入单价");
      return;
    }
    if (addWorkRecordsTeamSizeController.value.text.isEmpty) {
      EasyLoading.showError("请输入团队人数");
      return;
    }
    HttpRequest().addWorkRecords(
        {
          "teamSize" : addWorkRecordsTeamSizeController.value.text,
          "workDate" : workDate.value,
          "productPrice" : addWorkRecordsProductPriceController.value.text,
          "productQuantity" : addWorkRecordsProductQuantityController.value.text,
        },
        requestResult: BoolRequestResult(
            success: (){
              EasyLoading.showSuccess("提交成功");
              _getWorkRecordsByDay();
              getCurrentMonthRecords();
            },
            error: (error){
              EasyLoading.showError(error.message);
            })
    );
  }


}