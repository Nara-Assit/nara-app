import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/features/auth/data/repos/register_repo.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      final RegisterRepository registerRepository = RegisterRepository();
      final result = await registerRepository.register(email, password);
      // On success
      log('Register successful: $result');
      emit(RegisterSuccess());
    } catch (e) {
      log('Register failed: $e');
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
