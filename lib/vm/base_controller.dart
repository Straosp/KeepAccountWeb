import 'package:get/get.dart';


abstract class BaseController extends GetxController with StateMixin {

  void retry();

  @override
  void onReady() {
    super.onReady();
    change(null,status: RxStatus.loading());
  }

}