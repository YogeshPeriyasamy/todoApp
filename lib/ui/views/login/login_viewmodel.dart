import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final navService = locator<NavigationService>();

  final supaBase = Supabase.instance.client;

  bool ispasswordVisible = false;

  String formMessage = "";

  void navToSignup() {
    navService.replaceWithSignUpView();
  }

  void togglePasswordVisiblity() {
    ispasswordVisible = !ispasswordVisible;
    notifyListeners();
  }

  Future<void> logIn() async {
    setBusy(true);
    try {
      print("trying to log in");
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      //login auth
      final response = await supaBase.auth
          .signInWithPassword(password: password, email: email);

      if (response.user != null) {
        print("succesfully logged in ${response.user}");
        setBusy(false);
        navService.replaceWithDashboardView();
      }
    } on AuthException catch (err) {
      if (err.message.contains("Email not confirmed")) {
        formMessage = "Please confirm your mail before logging in";
      } else {
        print("Supabase auth failed with $err");
      }
      setBusy(false);
    }
  }
}
