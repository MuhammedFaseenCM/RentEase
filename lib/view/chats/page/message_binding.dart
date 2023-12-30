import 'package:rentease/view/chats/chat.dart';
import 'package:rentease/view/chats/page/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
