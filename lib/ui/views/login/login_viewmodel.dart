import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final navService = locator<NavigationService>();

  bool ispasswordVisible = false;

  void navToSignup() {
    navService.replaceWithSignUpView();
  }

  void togglePasswordVisiblity() {
    ispasswordVisible = !ispasswordVisible;
    notifyListeners();
  }
}
