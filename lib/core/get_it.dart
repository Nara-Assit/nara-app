import 'package:get_it/get_it.dart';
import 'package:nara/features/home/business%20logic/change_text_voice_cubit.dart';
import 'package:nara/features/home/data/repositiries/change_text_to_voice_repo.dart';

final setUp = GetIt.instance;

Future<void> init() async {
  //repo
  setUp.registerLazySingleton(() => ChangeTextToVoiceRepo());
  //cubit
  setUp.registerFactory(() => ChangeTextVoiceCubit(setUp()));
}
