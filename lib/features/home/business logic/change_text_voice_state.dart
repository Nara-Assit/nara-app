import 'package:nara/features/home/data/models/change_text_to_voice_model.dart';
import '../../../../../core/networking/api_error_model.dart';

abstract class ChangeTextVoiceState {}

final class ChangeTextVoiceStateInitial extends ChangeTextVoiceState {}

final class ChangeTextVoiceStateLoading extends ChangeTextVoiceState {}

final class ChangeTextVoiceStateSuccess extends ChangeTextVoiceState {
  final ChangeTextToSpeachModel changeTextToSpeachModel;
  ChangeTextVoiceStateSuccess(this.changeTextToSpeachModel);
}

final class ChangeTextVoiceStateError extends ChangeTextVoiceState {
  final ApiErrorModel error;
  ChangeTextVoiceStateError(this.error);
}
