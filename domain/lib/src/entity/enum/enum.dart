import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

enum AppRoute {
  login,
  main,
}

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);
  final int serverValue;
}

enum LanguageCode {
  en(
      localeCode: LocaleConstants.en,
      serverValue: ServerRequestResponseConstants.en),
  ja(
      localeCode: LocaleConstants.ja,
      serverValue: ServerRequestResponseConstants.ja);

  const LanguageCode({
    required this.localeCode,
    required this.serverValue,
  });
  final String localeCode;
  final String serverValue;

  static LanguageCode get defaultValue => en;
}

enum NotificationType {
  unknown,
  newPost,
  liked,
}

enum BottomTab {
  home(icon: Icon(Icons.home), activeIcon: Icon(Icons.home)),
  search(icon: Icon(Icons.search), activeIcon: Icon(Icons.search)),
  myPage(icon: Icon(Icons.people), activeIcon: Icon(Icons.people)),
  chatGPT(icon: Icon(Icons.chat), activeIcon: Icon(Icons.chat));

  const BottomTab({
    required this.icon,
    required this.activeIcon,
  });
  final Icon icon;
  final Icon activeIcon;

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.home;
      case BottomTab.search:
        return S.current.search;
      case BottomTab.myPage:
        return S.current.myPage;
      case BottomTab.chatGPT:
        return S.current.chatGPT;
    }
  }
}

//Chat GPT
enum ChatMessageType { user, bot }
