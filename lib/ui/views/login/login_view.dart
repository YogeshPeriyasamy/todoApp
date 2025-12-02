import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  "Please sign in to continue",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 40,
                ),
                Material(
                  elevation: 8,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(3)),
                  child: TextField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Enter Email")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 8,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(3)),
                  child: TextField(
                      controller: viewModel.passwordController,
                      obscureText: !viewModel.ispasswordVisible,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Enter Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.togglePasswordVisiblity();
                              },
                              icon: Icon(viewModel.ispasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility)))),
                ),
                if (viewModel.formMessage.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    viewModel.formMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 6)
                        ]),
                    height: 40,
                    child: viewModel.isBusy
                        ? const SizedBox(
                            height: 1,
                            child: LinearProgressIndicator(
                              color: Colors.blue,
                            ))
                        : MaterialButton(
                            onPressed: () {
                              viewModel.logIn();
                            },
                            child: const Text("Login"),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                viewModel.navToSignup();
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
