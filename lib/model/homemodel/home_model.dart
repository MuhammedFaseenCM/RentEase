import 'package:get/get.dart';

class HomeGetx extends GetxController {
  var selectedIndex = 0.obs;
  var email = ''.obs;
  void assignEmail(value) {
    email.value = value;
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  bool changePage = false;
  void changePageBool(bool value) {
    changePage = value;
  }
}
