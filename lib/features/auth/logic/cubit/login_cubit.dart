import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/core/helpers/storage_constants.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/auth/data/repos/login_repo.dart';
import 'package:nara/features/otp/otp_screen.dart';

import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../bottomnavbar/ui/bottom_nav_bar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final LoginRepository loginRepository = LoginRepository();
      final result = await loginRepository.login(email, password);
      if (result.data!.user.isVerified) {
        SharedprefHelper.setSecurityString(
          StorageConstants.savedToken,
          result.data!.accessToken!,
        );
        SharedprefHelper.setSecurityString(
          StorageConstants.refreshToken,
          result.data!.refreshToken!,
        );
        Go.to(const BottomNavBarScreen());
      } else {
        Go.to(
          OtpScreen(
            email: email,
            isLoginScreen: true,
          ),
        );
      }

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
