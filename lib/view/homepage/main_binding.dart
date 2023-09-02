import 'package:get/get.dart';
import 'package:rentease/view/homepage/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
