import 'package:get/get.dart';
import 'package:rentease/view/signuppage/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
