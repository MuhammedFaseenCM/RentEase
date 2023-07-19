import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentease/model/addressmodel/edit_mobx.dart/edit_address_getx.dart';
import 'package:rentease/view/core/const_colors.dart';

Future<void> sendMessage(
    {required String receiverEmail,
    required String message,
    required String senderName,
    required String recieverName}) async {
  ProfileControl profileControl = ProfileControl();
 

  final snapshot = profileControl.docRef
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

  final chatCollection = FirebaseFirestore.instance.collection('chat');
  await chatCollection.doc(chatId).set({
    'participants': [senderEmail, receiverEmail],
    'names': [data['name'], recieverName],
    'message': message,
    'time': DateFormat("jm").format(DateTime.now()),
    'dateTimeNow': DateTime.now()
  });

  final userChatCollection =
      chatCollection.doc(chatId).collection('messages').doc();

  await userChatCollection.set({
    'message': message,
    'time': DateFormat("jm").format(DateTime.now()),
    'date': DateFormat("dd-MM-yyyy").format(DateTime.now()),
    'senderEmail': senderEmail,
    'receiverEmail': receiverEmail,
    'dateTimeNow': DateTime.now()
  });
}

String getChatId(String email1, String email2) {
  if (email1.compareTo(email2) < 0) {
    return '$email1-$email2';
  } else {
    return '$email2-$email1';
  }
}

Stream<List<QueryDocumentSnapshot>> getChatMessages(String chatId)async* {
  final chatCollection = FirebaseFirestore.instance.collection('chat');
  final messagesCollection = chatCollection.doc(chatId).collection('messages');

  yield* messagesCollection
      .orderBy('time', descending: true)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs);
}

Stream<List<QueryDocumentSnapshot>> getChatList() {
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();
  final chatsCollection = FirebaseFirestore.instance.collection('chat');

  return chatsCollection
      .where('participants', arrayContains: currentUserEmail)
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs);
}
