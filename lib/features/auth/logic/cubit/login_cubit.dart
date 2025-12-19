import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/auth/data/repos/login_repo.dart';
import 'package:nara/features/sms_code/sms_code_screen.dart';
import 'package:nara/features/verify/compeleted_screen.dart';
import 'package:nara/features/verify/verify_via_email_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final LoginRepository loginRepository = LoginRepository();
      final result = await loginRepository.login(email, password);
      // if (result.data!.user.isVerified) {
      if (result.data!.user.isVerified) {
        Go.to(const CompeletedScreen());
      } else {
        Go.to(const SmsCodeScreen());
      }

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
