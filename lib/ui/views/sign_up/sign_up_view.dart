import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_viewmodel.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignUpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              viewModel.navToSignin();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  "Please create your account to continue",
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
                    controller: viewModel.nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(8),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: "Enter Name"),
                  ),
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
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.grey),
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
                      obscureText: !viewModel.isPasswordVisible,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.grey),
                          labelText: "Enter Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.togglePasswordVisible();
                              },
                              icon: Icon(viewModel.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility)))),
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
                      controller: viewModel.confirmPasswordController,
                      obscureText: !viewModel.isConfirmPasswordVisible,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.grey),
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.toggleConfirmpasswordVisible();
                              },
                              icon: Icon(viewModel.isConfirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility)))),
                ),
                if (viewModel.formMessage.isNotEmpty)
                  SizedBox(
                    height: 10,
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    viewModel.formMessage,
                    style: TextStyle(
                        color: viewModel.formMessage == "Sucessfully SignedUp!"
                            ? Colors.green
                            : Colors.red),
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
                              viewModel.signUp();
                            },
                            child: const Text("SignUp"),
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
            const Text("Already have an account?"),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                viewModel.navToSignin();
              },
              child: const Text(
                "Login",
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
  SignUpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignUpViewModel();
}
