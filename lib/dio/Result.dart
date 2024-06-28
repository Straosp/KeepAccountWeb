
class Result<T>{
  Result({required this.message,required this.code, this.data,});

  Result.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    data = json['data'];
  }
  Result.fromMap(Map<String,dynamic> map) {
    message = map['message'];
    code = map['code'];
    data = map['data'];
  }

  String message = "";
  int code = 0;
  T? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['code'] = code;
    map['data'] = data as T;
    return map;
  }
  @override
  String toString() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write("code = $code");
    stringBuffer.write("\tmessage = $message");
    stringBuffer.write("\tdata = ${data.toString()}");
    return stringBuffer.toString();
  }

}