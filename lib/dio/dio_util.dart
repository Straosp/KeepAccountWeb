import 'package:dio/dio.dart';

import 'app_url.dart';
import 'header_interceptor.dart';
import 'network_constant.dart';


class DioUtil {
  static DioUtil? _instance;
  static Dio _dio = Dio();
  Dio get dio => _dio;

  DioUtil._internal() {
    _instance = this;
    _instance!._init();
  }

  factory DioUtil() => _instance ?? DioUtil._internal();

  static DioUtil? getInstance() {
    _instance ?? DioUtil._internal();
    return _instance;
  }

  _init() {
    // 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: AppUrl.baseUrl,
        connectTimeout:  const Duration(seconds: NetworkConstant.CONNECT_TIMEOUT),
        receiveTimeout: const Duration(seconds: NetworkConstant.RECEIVE_TIMEOUT)
    );
    // 初始化dio
    _dio = Dio(options);

    // 添加拦截器
    _dio.interceptors.add(HeaderInterceptor());

  }


  /// 请求类
  Future<dynamic> get(String path, { Map<String, dynamic>? params, dynamic data}) async {
    try {
      Response response;
      response = await _dio.request(path,
        data: data,
        queryParameters: params,
        options: Options(method: "get"),
      );
      return response.data;
    } on DioException catch (e) {
      Response response = Response(requestOptions: e.requestOptions);
      response.statusCode = 500;
      return response.data;
    }
  }

  /// 请求类
  Future<dynamic> post(String path, {
    required Map<String,dynamic> params,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try{
      if(options == null){
        options = Options(method: "post");
      }else {
        options.method = "post";
      }
      try {
        Response response = await _dio.post(path, data: params, options: options, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
        return response.data;
      } on DioException catch (e) {
        Response response = Response(requestOptions: e.requestOptions);
        response.statusCode = 500;
        return response.data;
      }
    }catch(e){
      Response response = Response(requestOptions: RequestOptions(path: path),statusMessage: "网络请求异常，请稍后重试");
      response.statusCode = 500;
      return response.data;
    }

  }



}