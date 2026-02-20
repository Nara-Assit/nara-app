import 'dart:developer';
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
import '../../business logic/change_text_voice_cubit.dart';
import '../../business logic/change_text_voice_state.dart';
import '../../data/models/message_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void sendMessage(ChangeTextVoiceCubit cubit) {
      final text = _controller.text.trim();
      if (text.isEmpty || cubit.state is ChangeTextVoiceLoading) return;
      cubit.changeTextToVoice(text);
      _controller.clear();
    }

    return BlocProvider(
      create: (context) => di.setUp<ChangeTextVoiceCubit>()..loadMessages(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            //resizeToAvoidBottomInset: true,
            backgroundColor: ColorManager.whiteColors,
            appBar: const CustomAppBar(
              pathAsset: AppAssets.imagesCommunityIcon,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        BlocConsumer<
                          ChangeTextVoiceCubit,
                          ChangeTextVoiceState
                        >(
                          listener: (context, state) {
                            if (state is ChangeTextVoiceError &&
                                state.failedMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'فشل في إرسال لرسالة. الرجاء المحاولة مرة أخرى.',
                                  ),
                                ),
                              );
                              log("home screen${state.toString()}");
                            }
                          },
                          builder: (context, state) {
                            final messages = state.messages;

                            if (messages.isEmpty) {
                              return SliverFillRemaining(
                                child: Center(
                                  child: Image.asset(AppAssets.imagesMain),
                                ),
                              );
                            }
                            return SliverPadding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 20.h,
                              ),
                              sliver: SliverList.separated(
                                itemCount: messages.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final msg = messages[index];

                                  if (state is ChangeTextVoiceError &&
                                      state.failedMessage == msg) {
                                    return TextButton(
                                      onPressed: () {
                                        context
                                            .read<ChangeTextVoiceCubit>()
                                            .retryMessage(msg);
                                      },
                                      child: const Text(
                                        "حاول مرة أخرى",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  }
                                  if (msg.type == MessageType.text) {
                                    return buildMesaage(msg.content);
                                  } else {
                                    return VoiceMessageBubble(
                                      path: msg.content,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomChatWidget(
                    sendMessage: () => sendMessage(
                      context.read<ChangeTextVoiceCubit>(),
                    ),
                    controller: _controller,
                    onSendVoice: (file) =>
                        context.read<ChangeTextVoiceCubit>().sendVoice(file),
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
