import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/components/custom_build_messages.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/home/business%20logic/change_text_voice_cubit.dart';
import 'package:nara/features/home/business%20logic/change_text_voice_state.dart';
import 'package:nara/features/home/presentation/widgets/custom_chat_widget.dart';
import '../../../../core/components/build_voice_message.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/get_it.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<MessageModel> messages = [];

  void _sendTextMessage(ChangeTextVoiceCubit cubit) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(
        MessageModel(
          type: MessageType.text,
          content: text,
        ),
      );
    });

    _controller.clear();

    // نرسل النص للسيرفر عن طريق cubit
    cubit.changeTextToVoice(text);
  }

  void _addVoiceMessage(String path) {
    setState(() {
      messages.add(
        MessageModel(
          type: MessageType.voice,
          content: path,
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeTextVoiceCubit>(
      create: (_) => di.setUp<ChangeTextVoiceCubit>(),
      child: Builder(
        builder: (context) {
          // هنا نجيب cubit ونمرره لكل الfunctions
          final cubit = context.read<ChangeTextVoiceCubit>();

          return Scaffold(
            backgroundColor: ColorManager.whiteColors,
            appBar: const CustomAppBar(
              pathAsset: AppAssets.communityIcon,
            ),
            body: BlocListener<ChangeTextVoiceCubit, ChangeTextVoiceState>(
              listener: (context, state) {
                if (state is ChangeTextVoiceStateSuccess) {
                  _addVoiceMessage(state.changeTextToSpeachModel.publicUrl);
                }

                if (state is ChangeTextVoiceStateError) {
                  // ممكن هنا SnackBar أو Toast
                }
              },
              child: Column(
                children: [
                  if (messages.isEmpty) ...[
                    const Spacer(),
                    Center(
                      child: Image.asset(AppAssets.mainAvatar),
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
                          } else {
                            return VoiceMessageBubble(path: msg.content);
                          }
                        },
                      ),
                    ),
                  ),

                  // تمرير cubit كوسيط بدل context.read
                  CustomChatWidget(
                    controller: _controller,
                    sendMessage: () => _sendTextMessage(cubit),
                    onSendVoice: _addVoiceMessage,
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

enum MessageType { text, voice }

class MessageModel {
  final MessageType type;
  final String content;

  MessageModel({required this.type, required this.content});
}
