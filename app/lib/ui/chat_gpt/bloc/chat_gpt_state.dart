import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'chat_gpt_state.freezed.dart';

@freezed
class ChatGPTState extends BaseBlocState with _$ChatGPTState {
  const ChatGPTState._();

  const factory ChatGPTState({
    @Default('') String id,
    @Default('') String text,
    @Default(ChatMessageType.user) ChatMessageType chatMessageType,
  }) = _ChatGPTState;
}
