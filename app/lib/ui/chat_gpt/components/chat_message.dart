import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {required this.text, required this.chatMessageType, super.key});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? const Color(0xff10a37f)
          : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff10a37f),
                    child: Image.asset(
                      Assets.images.bot.path,
                      // color: Colors.white,
                      // scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: chatMessageType == ChatMessageType.bot
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
