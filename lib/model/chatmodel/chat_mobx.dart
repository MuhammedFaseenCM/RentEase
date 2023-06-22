import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'chat_mobx.g.dart';

class ChatModel = _ChatModel with _$ChatModel;

abstract class _ChatModel with Store {
  TextEditingController sendMessageController = TextEditingController();

  FocusNode focusNode = FocusNode();
}
