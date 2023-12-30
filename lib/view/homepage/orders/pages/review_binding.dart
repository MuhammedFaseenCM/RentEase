import 'package:get/get.dart';
import 'package:rentease/view/homepage/orders/pages/review_controller.dart';

class ReviewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
  }
}
