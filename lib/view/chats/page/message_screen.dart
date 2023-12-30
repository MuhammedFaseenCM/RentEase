import 'package:rentease/view/chats/page/message_controller.dart';

import '../chat.dart';

class MessageScreen extends GetView<MessageController> {

  const MessageScreen({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(title: controller.getReceiverName()),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messagesList(),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _messageTextField(),
                kwidth10,
                _sendButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder _messagesList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .doc(controller.getChatId(
                FirebaseAuth.instance.currentUser!.email.toString(),
                controller.getReceiverMail()))
            .collection("messages")
            .orderBy('dateTimeNow', descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
            List<Map<String, dynamic>> items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();
            if (items.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final messageField = items[index];
                  return messagesCard(messageField['senderEmail'],
                      messageField["message"], messageField["time"]);
                },
              );
            }
          }
          return const Center(
            child: Text("No messages yet"),
          );
        });
  }

  FloatingActionButton _sendButton() {
    return FloatingActionButton(
      backgroundColor: kOrange900,
      child: const Icon(
        Icons.send,
        color: kwhiteColor,
      ),
      onPressed: () async {
        if (controller.sendMessageController.text.isEmpty) {
          return;
        }
        await controller.sendMessage(
            receiverEmail: controller.getReceiverMail(),
            message: controller.sendMessageController.text,
            recieverName: controller.getSenderName(),
            senderName: controller.getSenderName(),);
        controller.sendMessageController.clear();
        controller.focusNode.unfocus();
      },
    );
  }

  Expanded _messageTextField() {
    return Expanded(
      child: TextFormField(
        controller: controller.sendMessageController,
        focusNode:controller.focusNode,
        decoration: const InputDecoration(
          hintText: 'Type a message...',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

Widget messagesCard(senderEmail, message, time) {
  bool check =
      FirebaseAuth.instance.currentUser!.email.toString() == senderEmail;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (check) const Spacer(),
        if (!check)
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 10,
            child: Icon(
              Icons.person,
              size: 13,
              color: Colors.white,
            ),
          ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10),
            decoration: messagesCardStyle(check),
            child: Text(
              '$message\n\n$time',
              style: TextStyle(color: check ? Colors.white : Colors.black),
            ),
          ),
        ),
        if (check)
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 10,
            child: Icon(
              Icons.person,
              size: 13,
              color: Colors.white,
            ),
          ),
        if (!check) const Spacer(),
      ],
    ),
  );
}

messagesCardStyle(check) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: check ? Colors.blue.shade900 : Colors.grey.shade300,
  );
}
