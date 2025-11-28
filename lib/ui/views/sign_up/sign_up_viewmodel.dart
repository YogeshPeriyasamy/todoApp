import 'package:flutter/widgets.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void navToSignin() {
    navService.replaceWithLoginView();
  }

  void togglePasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmpasswordVisible() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }
}
