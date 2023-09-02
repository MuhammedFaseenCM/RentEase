import 'address.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressController());
  }
}
