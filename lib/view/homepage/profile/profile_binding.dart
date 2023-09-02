import 'package:get/get.dart';
import 'package:rentease/view/homepage/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
