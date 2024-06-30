
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keep_account_web/utils/datetime_utils.dart';
import 'package:keep_account_web/vm/base_controller.dart';

import '../bean/work_records.dart';
import '../dio/DefaultRequestResult.dart';
import '../dio/http_request.dart';

class WorkRecordsHistoryController extends BaseController {


  var year = getCurrentYear().toInt().obs;
  var month = getCurrentMonth().toInt().obs;
  var workRecords = <WorkRecords>[].obs;

  var productQuantityController = TextEditingController();
  var productPriceController = TextEditingController();
  var teamSizeController = TextEditingController();

  var totalSalary = .0.obs;
  var totalDays = 0.obs;
  var monthTotalProductQuantity = .0.obs;

  @override
  void onReady() {
    super.onReady();
    getWorkRecordByYearMonth();
  }

  void lastMonth(){
    if (month.value == 1) {
      year.value -= 1;
      month.value = 12;
    }else{
      month.value -= 1;
    }
    getWorkRecordByYearMonth();
  }

  void nextMonth(){
    if (month.value == 12) {
      year.value += 1;
      month.value = 1;
    }else{
      if (month.value == getCurrentMonth() && year.value == getCurrentYear()) {
        EasyLoading.showInfo("未来的日子以后探索吧");
        return;
      }else {
        month.value += 1;
      }
    }
    getWorkRecordByYearMonth();
  }

  void getWorkRecordByYearMonth(){
    HttpRequest().getWorkRecordsByYearMonth(
      {
        "year": year.value,
        "month": month.value
      },
        requestResult: DefaultRequestResult(
            success: (data){
              totalSalary.value = .0;
              monthTotalProductQuantity.value = .0;
              workRecords.clear();
              if (data == null || (data as List<dynamic>).isEmpty) {
                change(null,status: RxStatus.empty());
                return;
              }
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
              workRecords.addAll(result);
              change(null,status: RxStatus.success());
            },
            emptyData: (){
              totalSalary.value = .0;
              monthTotalProductQuantity.value = .0;
              workRecords.clear();
              change(null,status: RxStatus.empty());
            },
            error: (error){
              workRecords.clear();
              EasyLoading.showError("暂无数据");
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
              getWorkRecordByYearMonth();
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


  @override
  void retry() {
    getWorkRecordByYearMonth();
  }

}