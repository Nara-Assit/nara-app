import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/features/home/business%20logic/change_text_voice_state.dart';
import 'package:nara/features/home/data/repositiries/change_text_to_voice_repo.dart';

class ChangeTextVoiceCubit extends Cubit<ChangeTextVoiceState> {
  final ChangeTextToVoiceRepo changeTextToVoiceRepo;
  ChangeTextVoiceCubit(this.changeTextToVoiceRepo)
    : super(ChangeTextVoiceStateInitial());
  Future<void> changeTextToVoice(
    String text,
  ) async {
    emit(ChangeTextVoiceStateLoading());
    final result = await changeTextToVoiceRepo.changeTextToVoice(text);
    result.fold(
      (error) => emit(ChangeTextVoiceStateError(error)),
      (voice) => emit(ChangeTextVoiceStateSuccess(voice)),
    );
  }
}
