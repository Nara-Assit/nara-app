import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/components/custom_build_messages.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/home/presentation/widgets/custom_chat_widget.dart';
import '../../../../core/components/build_voice_message.dart';
import '../../../../core/components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<MessageModel> messages = [];
  void sendMessage() {
    setState(() {
      messages.add(
        MessageModel(type: MessageType.text, content: _controller.text.trim()),
      );
    });
  }

  void sendVoice(String path) {
    setState(() {
      messages.add(MessageModel(type: MessageType.voice, content: path));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColors,
      appBar: const CustomAppBar(
        pathAsset: AppAssets.communityIcon,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                separatorBuilder: (context, index) => SizedBox(
                  height: 12.h,
                ),

                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  if (msg.type == MessageType.text) {
                    return buildMesaage(msg.content);
                  } else {
                    return VoiceMessageBubble(
                      path: msg.content,
                    );
                  }
                },
              ),
            ),
          ),
          CustomChatWidget(
            sendMessage: sendMessage,
            controller: _controller,
            onSendVoice: sendVoice,
          ),
        ],
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
