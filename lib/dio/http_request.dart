import '../bean/work_records.dart';
import 'DefaultRequestResult.dart';
import 'Result.dart';
import 'app_url.dart';
import 'dio_util.dart';

class HttpRequest {

  DioUtil? _dioUtil;

  HttpRequest(){
    _dioUtil = DioUtil();
  }

  void userLogin(String phone, {required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.login, params: {"phone": phone});
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

  void registerAndLogin(Map<String,dynamic> params,{required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.register, params: params);
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

  void getCurrentMonthWorkRecords({required RequestResult requestResult}) async {
    try{
      var result = await _dioUtil?.post(AppUrl.getCurrentMonthWorkRecords, params: {});
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

  void getAllUserList({required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.getAllUser, params: {});
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }
  void addWorkRecords(Map<String,dynamic> params, {required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.addWorkRecord, params: params);
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

  void updateWorkRecords(WorkRecords workRecords, {required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.updateWorkRecords, params: workRecords.toJson());
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

  void getWorkRecordsRangeYear(Map<String,dynamic> params,{required RequestResult requestResult}) async {
    try {
      Result result = await _dioUtil?.post(
          AppUrl.getWorkRecordsRangeYear, params: params);
      requestResult.launch(result);
    } catch (_) {
      requestResult.launchError();
    }
  }

  void getWorkRecordsRangeMonth(Map<String,dynamic> params,{required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.getWorkRecordsRangeMonth, params: params);
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }

    void getWorkRecordsRangeDay(Map<String,dynamic> params,{required RequestResult requestResult}) async {
      try{
        Result result = await _dioUtil?.post(AppUrl.getWorkRecordsRangeDay, params: params);
        requestResult.launch(result);
      }catch(_){
        requestResult.launchError();
      }
    }
  void deleteWorkRecordsById(int id,{required RequestResult requestResult}) async {
    try{
      Result result = await _dioUtil?.post(AppUrl.deleteWorkRecordsById, params: {"id": id});
      requestResult.launch(result);
    }catch(_){
      requestResult.launchError();
    }
  }





}