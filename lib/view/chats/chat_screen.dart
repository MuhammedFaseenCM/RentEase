import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/view/chats/message_screen.dart';
import 'package:rentease/view/core/appbar_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: "Chat"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .where('participants',
                    arrayContains:
                        FirebaseAuth.instance.currentUser!.email.toString())
                .orderBy("dateTimeNow", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final chats = snapshot.data!;
              List<QueryDocumentSnapshot> documents = chats.docs;
              List<Map<String, dynamic>> items = documents
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
              if (items.isEmpty) {
                return const Center(child: Text('No chats found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final chat = items[index];

                  ///  final chatData = chat.data();
                  if (chat.isEmpty) {
                    return const Center(child: Text('No chats found.'));
                  }

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                          chat['participants'][0] ==
                                  FirebaseAuth.instance.currentUser!.email
                                      .toString()
                              ? chat['names'][1]
                              : chat['names'][0],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(chat['message']),
                      trailing: Text(chat['time']),
                      onTap: () {
                        // Navigate to the chat screen for this chat
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(
                              recieverEmail: chat['participants'][0] ==
                                      FirebaseAuth.instance.currentUser!.email
                                          .toString()
                                  ? chat['participants'][1]
                                  : chat['participants'][0],
                              senderName: chat['participants'][0] ==
                                      FirebaseAuth.instance.currentUser!.email
                                          .toString()
                                  ? chat['names'][1]
                                  : chat['names'][0],
                              recieverName: chat['participants'][0] ==
                                      FirebaseAuth.instance.currentUser!.email
                                          .toString()
                                  ? chat['names'][1]
                                  : chat['names'][0],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }));
  }
}
