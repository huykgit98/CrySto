import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'chat_gpt_event.freezed.dart';

abstract class ChatGPTEvent extends BaseBlocEvent {
  const ChatGPTEvent();
}

@freezed
class ChatGPTPageInitiated extends ChatGPTEvent with _$ChatGPTPageInitiated {
  const factory ChatGPTPageInitiated({
    required int id,
  }) = _ChatGPTPageInitiated;
}
