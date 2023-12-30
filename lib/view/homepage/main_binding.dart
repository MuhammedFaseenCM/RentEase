import 'package:get/get.dart';
import 'package:rentease/view/homepage/main_controller.dart';
import 'package:rentease/view/homepage/notification/notify_controller.dart';
import 'package:rentease/view/homepage/orders/order_controller.dart';
import 'package:rentease/view/homepage/profile/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<NotifyController>(() => NotifyController());
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
