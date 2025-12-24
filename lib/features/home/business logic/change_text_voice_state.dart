import '../../../../../core/networking/api_error_model.dart';
import '../data/models/message_model.dart';

sealed class ChangeTextVoiceState {
  final List<MessageModel> messages;
  const ChangeTextVoiceState(this.messages);
}

final class ChangeTextVoiceInitial extends ChangeTextVoiceState {
  const ChangeTextVoiceInitial() : super(const []);
}

final class ChangeTextVoiceLoading extends ChangeTextVoiceState {
  const ChangeTextVoiceLoading(super.messages);
}

final class ChangeTextVoiceSuccess extends ChangeTextVoiceState {
  const ChangeTextVoiceSuccess({
    required List<MessageModel> messages,
  }) : super(messages);
}

final class ChangeTextVoiceError extends ChangeTextVoiceState {
  final ApiErrorModel error;
  final MessageModel? failedMessage; // الرسالة اللي فشلت

  const ChangeTextVoiceError({
    required this.error,
    this.failedMessage,
    required List<MessageModel> messages,
  }) : super(messages);
}
