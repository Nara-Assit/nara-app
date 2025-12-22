import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/components/custom_build_messages.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/home/presentation/widgets/custom_chat_widget.dart';
import '../../../../core/components/build_voice_message.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/get_it.dart' as di;
import '../../../../core/helpers/db_helper.dart';
import '../../business logic/change_text_voice_cubit.dart';
import '../../business logic/change_text_voice_state.dart';
import '../../data/models/message_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<MessageModel> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final savedMessages = await LocalDatabaseHelper.getAllMessages();
    setState(() {
      messages = savedMessages;
      isLoading = false;
    });
  }

  Future<void> sendMessage(ChangeTextVoiceCubit cubit) async {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text.trim();
    setState(() {
      messages.add(
        MessageModel(
          type: MessageType.text,
          content: text,
          sender: 'user',
        ),
      );
    });
    _controller.clear();
    cubit.changeTextToVoice(text);
  }

  void sendVoice(String path) async {
    final voiceMessage = MessageModel(
      type: MessageType.voice,
      content: path,
      sender: 'bot',
    );
    await LocalDatabaseHelper.insertMessage(voiceMessage);
    setState(() {
      messages.add(voiceMessage);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.setUp<ChangeTextVoiceCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: ColorManager.whiteColors,
            appBar: const CustomAppBar(
              pathAsset: AppAssets.imagesCommunityIcon,
            ),
            body: BlocListener<ChangeTextVoiceCubit, ChangeTextVoiceState>(
              listener: (context, state) {
                if (state is ChangeTextVoiceStateSuccess) {
                  setState(() {
                    messages.add(
                      MessageModel(
                        type: MessageType.voice,
                        content: state.changeTextToSpeachModel.publicUrl,
                        sender: 'bot',
                      ),
                    );
                  });
                } else if (state is ChangeTextVoiceStateError) {
                  setState(() {
                    final lastMessage = messages.last;
                    messages.removeLast();
                    messages.add(
                      MessageModel(
                        type: MessageType.text,
                        content: "",
                        sender: 'bot',
                        originalText: lastMessage.originalText,
                        status: MessageStatus.failure,
                      ),
                    );
                  });
                }
              },
              child: Column(
                children: [
                  if (messages.isEmpty) ...[
                    const Spacer(),
                    Center(
                      child: Image.asset(AppAssets.imagesMain),
                    ),
                  ],

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      child: ListView.separated(
                        itemCount: messages.length,
                        separatorBuilder: (_, _) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          if (msg.type == MessageType.text) {
                            return buildMesaage(msg.content);
                          } else if (msg.status == MessageStatus.failure) {
                            return TextButton(
                              onPressed: () {
                                sendMessage(
                                  context.read<ChangeTextVoiceCubit>(),
                                );
                              },
                              child: const Text("retry"),
                            );
                          } else {
                            return VoiceMessageBubble(path: msg.content);
                          }
                        },
                      ),
                    ),
                  ),
                  CustomChatWidget(
                    sendMessage: () =>
                        sendMessage(context.read<ChangeTextVoiceCubit>()),
                    controller: _controller,
                    onSendVoice: sendVoice,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
