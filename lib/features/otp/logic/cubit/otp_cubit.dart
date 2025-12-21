import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/core/helpers/toast_messages.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/bottomnavbar/ui/bottom_nav_bar.dart';
import 'package:nara/features/home/presentation/screen/home_screen.dart';
import 'package:nara/features/otp/data/repos/otp_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  String otp = "";

  Future<void> verify(String email) async {
    emit(OtpLoading());
    try {
      final result = await OtpRepository().verify(email, otp);
      if (result.success) {
        Go.to(const BottomNavBarScreen());
      } else {
        ToastMessages.showSimpleToast(msg: result.message);
      }
    } catch (e) {
      emit(OtpFailure(error: e.toString()));
    }
  }

  Future<void> resend(String email) async {
    try {
      await OtpRepository().resend(email);
    } catch (e) {
      emit(OtpFailure(error: e.toString()));
    }
  }
}
