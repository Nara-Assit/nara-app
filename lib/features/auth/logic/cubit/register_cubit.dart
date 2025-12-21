import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/features/auth/data/models/register_request_model.dart';
import 'package:nara/features/auth/data/repos/register_repo.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../bottomnavbar/ui/bottom_nav_bar.dart';
import '../../../otp/otp_screen.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String role = "";
  TextEditingController countryController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController closeContactNumberController = TextEditingController();

  Future<void> register() async {
    emit(RegisterLoading());
    try {
      final RegisterRepository registerRepository = RegisterRepository();
      final RegisterRequestModel requestModel = RegisterRequestModel(
        name: nameController.text,
        email: emailController.text,
        password: passController.text,
        role: role,
        country: countryController.text,
        age: int.parse(ageController.text),
        closeContactNumber: closeContactNumberController.text,
      );
      log("regisre model $requestModel");
      final result = await registerRepository.register(requestModel);
      if (result.success) {
        Go.to(OtpScreen(email: requestModel.email));
      }
      // On success
      log('Register successful: $result');
      emit(RegisterSuccess());
    } catch (e) {
      log('Register failed: $e');
      emit(RegisterFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    ageController.dispose();
    closeContactNumberController.dispose();
    countryController.dispose();
    return super.close();
  }
}
