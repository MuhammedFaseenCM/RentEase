import 'package:rentease/model/chat_model.dart';

import 'chat.dart';

class ChatController extends GetxController {
  FocusNode focusNode = FocusNode();

  List<Map<String, dynamic>> items = [];

  late Chat chat;

  String currentUser = FirebaseAuth.instance.currentUser!.email.toString();

  Stream get chatStream => FirebaseFirestore.instance
      .collection('chat')
      .where('participants', arrayContains: currentUser)
      .orderBy("dateTimeNow", descending: true)
      .snapshots();

  fetchChatData(snapshot) {
    final chats = snapshot.data!;
    List<QueryDocumentSnapshot> documents = chats.docs;
    items = documents.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  late String receiverEmail;
  late String senderEmail;

  String getReceiverName(chat) => chat['participants'][0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat['names'][1]
      : chat['names'][0];

  String getReceiverMail(chat) => chat['participants'][0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat['names'][1]
      : chat['names'][0];

  String getSenderName(chat) => chat['participants'][0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat['names'][1]
      : chat['names'][0];

  @override
  void onInit() {
    super.onInit();
  }
}
