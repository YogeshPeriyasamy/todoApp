import 'package:flutter/widgets.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final supaBase = Supabase.instance.client;

  String formMessage = "";

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

  Future<void> signUp() async {
    setBusy(true);
    try {
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      bool isFormValid = await validateform(email, password, confirmPassword);
      print(isFormValid);
      if (isFormValid == true) {
        print("form is valid");

        //using supabase to add user
        final response = await supaBase.auth
            .signUp(password: password, email: email, data: {"name": name});

        if (response.user != null) {
          print("signUp succesful ${response.user}");
          formMessage = "Sucessfully SignedUp!";
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          setBusy(false);
          notifyListeners();
          // navService.replaceWithLoginView();
        }
      } else {
        setBusy(false);
        print(formMessage);
        print("form is not valid");
      }
    } catch (err) {
      setBusy(false);
      formMessage = "Can't signUp please try again";
      print("error in supabase signup page $err");
    }
  }

  bool validateform(String email, String password, String confirmPassword) {
    if (!email.contains("@") || !email.contains(".")) {
      formMessage = "The entered email is not valid";
    } else if (password.length < 6) {
      formMessage = "Password is not strong";
    } else if (password != confirmPassword) {
      formMessage = "Password and Confirm Password mismatched";
    } else {
      formMessage = "";
    }
    notifyListeners();
    return email.contains("@") &&
        email.contains(".") &&
        password.length >= 6 &&
        password == confirmPassword;
  }
}
