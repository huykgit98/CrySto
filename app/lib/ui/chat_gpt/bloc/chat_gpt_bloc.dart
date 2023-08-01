import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'chat_gpt_event.dart';
import 'chat_gpt_state.dart';

@Injectable()
class ChatGPTBloc extends BaseBloc<ChatGPTEvent, ChatGPTState> {
  ChatGPTBloc() : super(const ChatGPTState()) {
    on<ChatGPTPageInitiated>(
      _onChatGPTPageInitiated,
      transformer: log(),
    );
  }

  void _onChatGPTPageInitiated(
    ChatGPTPageInitiated event,
    Emitter<ChatGPTState> emit,
  ) {
    // Xin hãy ghi nhớ đặt tên Event theo convention:
    // <Tên Widget><Verb ở dạng Quá khứ>. VD: LoginButtonPressed, EmailTextFieldChanged, HomePageRefreshed
  }
}
