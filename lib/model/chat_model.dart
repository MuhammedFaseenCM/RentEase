class Chat {
  final String message;
  final DateTime dateTime;
  final List<String> names;
  final List<String> participants;

  Chat({
    required this.message,
    required this.dateTime,
    required this.names,
    required this.participants,
  });

  factory Chat.fromJson(Map<String, dynamic> data) {
    return Chat(
      message: data['message'],
      dateTime: data['dateTimeNow'],
      names: data['names'],
      participants: data['participants'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'dateTime': dateTime,
      'names': names,
      'participants': participants,
    };
  }
}

class Message {
  final DateTime dateTime;
  final String message;
  final String sender;
  final String receiver;

  Message({
    required this.dateTime,
    required this.message,
    required this.receiver,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> data) {
    return Message(
      dateTime: data['dateTimeNow'],
      message: data['message'],
      receiver: data['receiverEmail'],
      sender: data['senderEmail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTimeNow': dateTime,
      'message': message,
      'receiverEmail': receiver,
      'senderEmail': sender
    };
  }
}
