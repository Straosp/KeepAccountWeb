import '../bean/ErrorMessage.dart';
import 'Result.dart';
import 'network_constant.dart';

abstract class RequestResult{
  void launch(Result result);
  void launchError();
}

typedef Success = void Function(dynamic data);
typedef EmptyData = void Function();
typedef Error = void Function(ErrorMessage errorMessage);

class DefaultRequestResult extends RequestResult {

  final Success success;
  final EmptyData emptyData;
  final Error error;

  DefaultRequestResult({required this.success,required this.emptyData,required this.error});

  @override
  void launch(Result? result) {
    if (result?.code == NetworkConstant.responseSuccessCode){
      if ((result?.data is Map) && (result?.data as Map<String,dynamic>).isEmpty){
        emptyData();
      } else if ((result?.data is List<dynamic>) && (result?.data as List<dynamic>).isEmpty){
        emptyData();
      } else if (result?.data is String && (result?.data as String).isEmpty){
        emptyData();
      }else{
        success(result?.data);
      }
    }else if (result?.code == NetworkConstant.responseNoDataCode){
      emptyData();
    } else {
      error(result?.data ?? ErrorMessage(0, "网络请求失败"));
    }
  }
  @override
  void launchError() {
    error(ErrorMessage(0, "网络请求失败"));
  }
}
class BoolRequestResult extends RequestResult {

  final EmptyData success;
  final Error error;

  BoolRequestResult({required this.success,required this.error});

  @override
  void launch(Result? result) {
    if (result?.code == NetworkConstant.responseSuccessCode || result?.code == NetworkConstant.responseNoDataCode){
      success();
    }else {
      error(result?.data ?? ErrorMessage(0, "网络请求失败"));
    }
  }
  @override
  void launchError() {
    error(ErrorMessage(0, "网络请求失败"));
  }
}
class MessageRequestResult extends RequestResult {

  final Success success;
  final Error error;

  MessageRequestResult({required this.success,required this.error});

  @override
  void launch(Result? result) {
    try{
      if (result?.code == NetworkConstant.responseSuccessCode){
        success(result?.message);
      }else {
        error(result?.data ?? ErrorMessage(0, "网络请求失败"));
      }
    }catch(e){
      error(result?.data ?? ErrorMessage(0, "网络请求失败"));
    }

  }
  @override
  void launchError() {
    error(ErrorMessage(0, "网络请求失败"));
  }
}