class ErrorMessage{

  int code = 0;
  String message = "";

  ErrorMessage(this.code,this.message);

  int getAttachCode(){
    return code ~/ 100;
  }
  @override
  String toString() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write("code = $code");
    stringBuffer.write("\tmessage = $message");
    return stringBuffer.toString();
  }

}