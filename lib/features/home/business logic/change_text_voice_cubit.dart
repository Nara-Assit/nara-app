import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/features/home/business%20logic/change_text_voice_state.dart';
import 'package:nara/features/home/data/repositiries/change_text_to_voice_repo.dart';
import '../../../core/helpers/db_helper.dart';
import '../data/models/message_model.dart';

class ChangeTextVoiceCubit extends Cubit<ChangeTextVoiceState> {
  final ChangeTextToVoiceRepo changeTextToVoiceRepo;

  ChangeTextVoiceCubit(this.changeTextToVoiceRepo)
    : super(const ChangeTextVoiceInitial());

  Future<void> changeTextToVoice(String text) async {
    final userMessage = MessageModel(
      type: MessageType.text,
      content: text,
      sender: 'user',
    );
    final updatedMessages = [...state.messages, userMessage];
    emit(
      ChangeTextVoiceSuccess(
        messages: [...state.messages, userMessage],
      ),
    );
    await LocalDatabaseHelper.insertMessage(userMessage);

    emit(ChangeTextVoiceLoading(updatedMessages));

    final result = await changeTextToVoiceRepo.changeTextToVoice(text);

    result.fold(
      (error) {
        emit(
          ChangeTextVoiceError(
            error: error,
            failedMessage: userMessage,
            messages: updatedMessages,
          ),
        );
      },
      (voice) async {
        final botMessage = MessageModel(
          type: MessageType.voice,
          content: voice.publicUrl,
          sender: 'bot',
        );

        await LocalDatabaseHelper.insertMessage(botMessage);

        emit(
          ChangeTextVoiceSuccess(
            messages: [...updatedMessages, botMessage],
          ),
        );
      },
    );
  }

  Future<void> sendVoice(String path) async {
    final voiceMessage = MessageModel(
      type: MessageType.voice,
      content: path,
      sender: 'bot',
    );
    await LocalDatabaseHelper.insertMessage(voiceMessage);
    emit(ChangeTextVoiceSuccess(messages: [...state.messages, voiceMessage]));
  }

  void retryMessage(MessageModel failedMessage) {
    changeTextToVoice(failedMessage.originalText ?? failedMessage.content);
  }

  Future<void> loadMessages() async {
    emit(ChangeTextVoiceLoading(state.messages));

    final messages = await LocalDatabaseHelper.getAllMessages();

    emit(ChangeTextVoiceSuccess(messages: messages));
  }
}
