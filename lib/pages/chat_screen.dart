import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_talks_flutter/fixedDatas/variables.dart';

import '../components/header.dart';
import '../components/bottom_navigation.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatScreen extends StatefulWidget {
  // キッチン、ホールでチャット画面を切り替えるためのloginStatusは各画面から送ってあります。
  const ChatScreen({super.key, required this.loginStatus, required this.guestNumber});
  final int loginStatus;
  final int guestNumber;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final int currentScreenId = chatScreenId;

  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  void _handleImageSelection() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: pickedImage.name,
        size: bytes.length,
        uri: pickedImage.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: Header(
      loginStatus: widget.loginStatus,
      guestNumber: widget.guestNumber,
      currentScreenId: currentScreenId,
    ),
    body: Chat(
      user: _user,
      messages: _messages,
      onAttachmentPressed: _handleImageSelection,
      onSendPressed: _handleSendPressed,
    ),
    bottomNavigationBar: BottomNavigation(
      screenId: currentScreenId,
      loginStatus: widget.loginStatus,
      guestNumber: widget.guestNumber,
      currentScreenId: currentScreenId,
    ),
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}