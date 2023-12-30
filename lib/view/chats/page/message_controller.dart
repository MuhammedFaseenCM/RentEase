import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/chat_model.dart';
import 'package:rentease/view/chats/chat.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/homepage/profile/profile_controller.dart';

class MessageController extends GetxController {
  TextEditingController sendMessageController = TextEditingController();

  FocusNode focusNode = FocusNode();

  late Chat chat;

  Future<void> sendMessage({
    required String receiverEmail,
    required String message,
    required String senderName,
    required String recieverName,
  }) async {
    final snapshot = Get.find<ProfileController>()
        .docRef
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
    Map? data;
    var docsnapshot = await snapshot.get();

    if (docsnapshot.exists) {
      data = docsnapshot.data();
    }
    if (data == null) {
      Get.snackbar("Please update your profile details", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kredColor,
          colorText: kwhiteColor);
      return;
    }
    final senderEmail = FirebaseAuth.instance.currentUser!.email.toString();
    final chatId = getChatId(senderEmail, receiverEmail);
    Map<String, dynamic> chatToJson = Chat(
      message: message,
      dateTime: DateTime.now(),
      names: [senderName, recieverName],
      participants: [senderEmail, receiverEmail],
    ).toMap();
    final chatCollection = FirebaseFirestore.instance.collection('chat');

    await chatCollection.doc(chatId).set(chatToJson);

    final userChatCollection =
        chatCollection.doc(chatId).collection('messages').doc();
    Map<String, dynamic> messageToJson = Message(
      message: message,
      dateTime: DateTime.now(),
      receiver: receiverEmail,
      sender: senderEmail,
    ).toMap();

    await userChatCollection.set(messageToJson);
  }

  String getChatId(String email1, String email2) {
    if (email1.compareTo(email2) < 0) {
      return '$email1-$email2';
    } else {
      return '$email2-$email1';
    }
  }

  Stream<List<QueryDocumentSnapshot>> getChatMessages(String chatId) async* {
    final chatCollection = FirebaseFirestore.instance.collection('chat');
    final messagesCollection =
        chatCollection.doc(chatId).collection('messages');

    yield* messagesCollection
        .orderBy('time', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  Stream<List<QueryDocumentSnapshot>> getChatList() {
    final currentUserEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    final chatsCollection = FirebaseFirestore.instance.collection('chat');

    return chatsCollection
        .where('participants', arrayContains: currentUserEmail)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  String getReceiverName() => chat.participants[0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat.names[1]
      : chat.names[0];

  String getReceiverMail() => chat.participants[0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat.participants[1]
      : chat.participants[0];

  String getSenderName() => chat.participants[0] ==
          FirebaseAuth.instance.currentUser!.email.toString()
      ? chat.names[1]
      : chat.names[0];

  @override
  void onInit() {
    super.onInit();

    // chat = Get.find<ChatController>().chat;
  }
}
