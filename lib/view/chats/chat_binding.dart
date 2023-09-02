import 'chat.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
