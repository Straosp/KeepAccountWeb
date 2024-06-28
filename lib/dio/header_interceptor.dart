import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../utils/getx_util.dart';
import '../utils/global.dart';
import 'Result.dart';
import 'api_error_message.dart';
import 'network_constant.dart';


class HeaderInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print("请求URL：\t ${options.uri.path}");
    print("请求参数 Body：\t ${options.data}");
    print("请求参数 Query：\t ${options.queryParameters}");
    print("请求header：\t ${options.headers}");
    print("请求方法：\t ${options.method}");
    print("Option Data = ${options.data}");
    var token = await Global().getToken();
    options.headers["Authorization"] = "Basic $token";
    options.headers["Access-Control-Allow-Origin"] = "*";
    handler.next(options);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 请求成功 对数据做基本处理
    var path = response.requestOptions.path;
    print("onResponse = ${response.data}  ${response.data.runtimeType}");
    if (response.data.runtimeType == ResponseBody){
      handler.next(response);
      return;
    }
    if (response.statusCode == 200) {
      if (response.data == null || (response.data ?? "" ).toString().isEmpty){
        var apiError = ApiErrorMessage().getApiErrorCode(NetworkConstant.networkErrorCode, path, null);
        response.data = Result(message: apiError.message, code: apiError.code,data: apiError);
        handler.next(response);
        return;
      }
      var data = response.data;
      var result = Result.fromJson(data);
      //var result = Result.fromMap(data as Map<String,dynamic>);
      if (result.code == NetworkConstant.responseSuccessCode){
        var apiError = ApiErrorMessage().getApiErrorCode(NetworkConstant.notDataCode, path,result.message);
        if (result.data == null){
          response.data = Result(message: result.message, code: NetworkConstant.responseNoDataCode, data: apiError);
        }else if(result.data.runtimeType == List && (result.data as List).isEmpty){
          response.data = Result(message: result.message, code: NetworkConstant.responseNoDataCode, data: apiError);
        }else {
          response.data = Result(message: result.message ?? "", code: result.code ?? 0, data: result.data);
        }
      } else {
        var apiError = ApiErrorMessage().getApiErrorCode(NetworkConstant.otherErrorAttachCode, path,result.message ?? "");
        response.data = Result(message: result.message ?? "", code: NetworkConstant.responseErrorCode, data: apiError);
      }
      //    }
    }else if (response.statusCode == HttpStatus.unauthorized) {
      var apiError = ApiErrorMessage().getApiErrorCode(NetworkConstant.tokenFailedAttachCode,  path,"Token Failed");
      response.data = Result(message: "Token Failed", code: NetworkConstant.tokenFailedCode, data: apiError);
      offAllNamed("/toLogin");
    }else {
      var apiError = ApiErrorMessage().getApiErrorCode(NetworkConstant.networkErrorCode, path,null);
      response.data = Result(message: apiError.message, code: apiError.code, data: apiError);
    }
    // 重点
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch(err.type) {
    // 连接服务器超时
      case DioExceptionType.connectionTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 101;
          handler.resolve(response);
        }
        break;
    // 响应超时
      case DioExceptionType.receiveTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 102;
          handler.resolve(response);
        }
        break;
    // 发送超时
      case DioExceptionType.sendTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 103;
          handler.resolve(response);
        }
        break;
    // 请求取消
      case DioExceptionType.cancel:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 104;
          handler.resolve(response);
        }
        break;
    // 404/503错误
      case DioExceptionType.badResponse:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 105;
          handler.resolve(response);
        }
        break;
    // other 其他错误类型
      case DioExceptionType.unknown:
        {
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 106;
          handler.resolve(response);
        }
        break;

      case DioExceptionType.badCertificate:
        {
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 106;
          handler.resolve(response);
        }
      case DioExceptionType.connectionError:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          Response response = Response(requestOptions: err.requestOptions);
          response.statusCode = 101;
          handler.resolve(response);
        }
    }
    //super.onError(err, handler);
  }

}