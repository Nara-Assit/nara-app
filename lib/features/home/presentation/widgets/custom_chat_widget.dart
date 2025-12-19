import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/features/home/presentation/widgets/chat_text_form_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theming/color_manager.dart';

class CustomChatWidget extends StatefulWidget {
  final VoidCallback sendMessage;
  final Function(String voicePath) onSendVoice;

  final TextEditingController controller;
  const CustomChatWidget({
    super.key,
    required this.sendMessage,
    required this.controller,
    required this.onSendVoice,
  });

  @override
  State<CustomChatWidget> createState() => _CustomChatWidgetState();
}

class _CustomChatWidgetState extends State<CustomChatWidget> {
  bool isTyping = false;
  final recorder = AudioRecorder();
  bool isRecording = false;
  Timer? timer;
  int seconds = 0;
  void sendMessage() {
    if (widget.controller.text.isEmpty) return;
    widget.sendMessage();
    widget.controller.clear();
    isTyping = false;
  }

  void startRecording() async {
    final bool hasPermission = await recorder.hasPermission();
    if (!hasPermission) return;

    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await recorder.start(const RecordConfig(), path: filePath);

    setState(() {
      isRecording = true;
      seconds = 0;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  void stopRecording({bool send = false}) async {
    timer?.cancel();
    final path = await recorder.stop();
    setState(() {
      isRecording = false;
      seconds = 0;
    });
    if (send && path != null) {
      widget.onSendVoice(path);
      log('Send voice file: $path');
    } else {
      log("Recording cancelled");
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 45.h,
            width: 45.w,
            margin: EdgeInsets.only(right: 24.w),
            child: isTyping
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorManager.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: Icon(
                        Icons.send,
                        color: ColorManager.whiteColors,
                        size: 24.r,
                      ),
                    ),
                  )
                : isRecording
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorManager.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () => stopRecording(send: true),
                      icon: Icon(
                        Icons.stop,
                        color: ColorManager.whiteColors,
                        size: 24.r,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: startRecording,
                    child: Image.asset(
                      AppAssets.voice,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () {},
          child: isTyping
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 45.h,
                  width: 45.w,
                  child: Image.asset(
                    AppAssets.camera,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        SizedBox(
          width: 10.w,
        ),
        ChatTextFormField(
          controller: widget.controller,
          isTyping: isTyping,
          onChanged: (text) {
            setState(() {
              isTyping = text.isNotEmpty;
            });
          },
        ),
      ],
    );
  }
}
