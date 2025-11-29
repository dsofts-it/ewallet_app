import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/models/chat.dart';
import 'package:ewallet_app/widgets/chat/chat_input.dart';
import 'package:ewallet_app/widgets/chat/chat_message.dart';

class ChatSupport extends StatefulWidget {
  const ChatSupport({super.key});

  @override
  State<ChatSupport> createState() => _ChatSupportState();
}

class _ChatSupportState extends State<ChatSupport> {
  List<MessageItem> initMsg = [];
  final _scrollController = ScrollController();

  void _sendMessage(MessageItem message){
    setState(() {
      initMsg.add(message);
    });

    /// Scroll to bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + kToolbarHeight + kBottomNavigationBarHeight + 32,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn
    );
  }

  @override
  void initState() {
    initMsg = message2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: spacingUnit(10)),
          child: ChatMessage(
            avatar: ImgApi.avatar[11],
            name: branding.name,
            chatMessages: initMsg,
            scrollCtrl: _scrollController,
            isAdmin: true,
          ),
        ),
        ChatInput(sendMsg: _sendMessage, hintText: 'Ask something...',),
      ],
    );
  }
}