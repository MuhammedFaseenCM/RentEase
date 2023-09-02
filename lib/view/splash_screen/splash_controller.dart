import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/services/routes/route_names.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (_auth.currentUser != null) {
        Get.offAndToNamed(RoutesName.home);
      } else {
        Get.offAndToNamed(RoutesName.login);
      }
    });
  }
}
