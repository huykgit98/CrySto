import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../app.dart';
import 'bloc/chat_gpt_bloc.dart';
import 'components/chat_message.dart';
import 'components/chatgpt_api.dart';

@RoutePage(name: 'ChatGPTRoute')
class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatGPTPageState();
  }
}

class _ChatGPTPageState extends BasePageState<ChatGPTPage, ChatGPTBloc> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;
  late bool isListening;
  final ChatGPTApi chatGPTApi =
      ChatGPTApi(apiKey: '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');
  final speechToText = stt.SpeechToText();
  final flutterTts = FlutterTts();
  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;
  String langCode = "en-US";
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    isLoading = false;
    isListening = false;
    final newLanguages = List<String>.from(await flutterTts.getLanguages);
    setState(() {
      languages = newLanguages;
    });
  }

  void _listen() async {
    _stop();
    if (!isListening) {
      final available = await speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          isListening = true;
          speechToText.listen(onResult: (result) {
            setState(() {
              _textController.text = result.recognizedWords;
            });
          });
        });
      }
    } else {
      setState(() => isListening = false);
      speechToText.stop();
    }
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setLanguage(langCode);
  }

  void _speak(text) async {
    initSetting();
    await flutterTts.speak(text);
  }

  void _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "OpenAI's ChatGPT Flutter",
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: const Color(0xff10a37f),
        actions: [
          if (languages != null)
            PopupMenuButton(
              itemBuilder: (context) => (languages ?? [])
                  .map(
                    (value) => PopupMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: langCode == value
                                  ? const Color(0xff10a37f)
                                  : Colors.black,
                            ),
                      ),
                    ),
                  )
                  .toList(),
              onSelected: (selectedValue) {
                setState(() {
                  langCode = selectedValue;
                });
              },
            )
        ],
      ),
      floatingActionButton: Visibility(
        visible: isListening,
        child: AvatarGlow(
          animate: isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: GestureDetector(
            onTap: _listen,
            child: const CircleAvatar(
              backgroundColor: Color(0xff10a37f),
              radius: 40,
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
              Visibility(
                visible: isLoading,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Color(0xff10a37f),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: !isListening,
                  child: Row(
                    children: [
                      _buildInput(),
                      const SizedBox(width: 5),
                      _buildSubmit(),
                      const SizedBox(width: 5),
                      _buildVoice(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (isListening) {
      return Center(
        child: Text(
          _textController.text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
        ),
      );
    }
    if (_messages.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xff10a37f),
            radius: 50,
            child: Image.asset(
              'assets/bot.png',
              color: Colors.white,
              scale: 0.6,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Text(
              'Hi, I\'m Huy\nTell me your dreams and i\'ll make them happen',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessage(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  Widget _buildVoice() {
    return Visibility(
      visible: !isLoading,
      child: GestureDetector(
        onTap: _listen,
        child: const CircleAvatar(
          backgroundColor: Colors.deepOrangeAccent,
          radius: 25,
          child: Icon(
            Icons.mic_none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff10a37f),
          borderRadius: BorderRadius.circular(
            6,
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Colors.white,
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            final input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            chatGPTApi.complete(input).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
                _speak(value);
              });
            }).catchError((error) {
              setState(
                () {
                  final snackBar = SnackBar(
                    content: Text(error.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  isLoading = false;
                },
              );
            });
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        minLines: 1,
        maxLines: 9,
        controller: _textController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
