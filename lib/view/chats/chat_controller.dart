import 'chat.dart';

class ChatController extends GetxController {
  TextEditingController sendMessageController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  void onClose() {
    super.onClose();
    sendMessageController.dispose();
  }
}
