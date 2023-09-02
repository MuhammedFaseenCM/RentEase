import 'package:get/get.dart';
import 'package:rentease/view/loginpage/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
