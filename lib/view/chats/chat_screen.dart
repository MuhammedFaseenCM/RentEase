import 'package:rentease/model/chat_model.dart';
import 'package:rentease/services/routes/route_names.dart';
import 'chat.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: "Chat"),
        ),
        body: StreamBuilder(
            stream: controller.chatStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              controller.fetchChatData(snapshot);
              if (controller.items.isEmpty) {
                return const Center(child: Text('No chats found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: controller.items.length,
                itemBuilder: (_, index) {
                  controller.chat = Chat.fromJson(controller.items[index]);

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(controller.getReceiverName(controller.chat),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(controller.chat.message),
                      trailing: Text(controller.chat.dateTime.toString()),
                      onTap: () {
                        Get.toNamed(RoutesName.message);
                      },
                    ),
                  );
                },
              );
            }));
  }
}
