import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/home/presentation/widgets/chat_text_form_field.dart';
import 'package:record/record.dart';
import '../../../../core/components/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isTyping = false;
  final recorder = AudioRecorder();
  bool isRecording = false;
  Timer? timer;
  int seconds = 0;
  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        //code logic
      });
    }
    _controller.clear();
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
      log('Send voice file: $path');
      setState(() {});
    } else {
      log("Recording cancelled");
    }
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
          const Spacer(),
          Center(child: Image.asset(AppAssets.mainAvatar)),
          const Spacer(),
          Row(
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
                            onPressed: stopRecording,
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
                controller: _controller,
                isTyping: isTyping,
                onChanged: (text) {
                  setState(() {
                    isTyping = text.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
