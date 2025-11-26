import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:realtodo/services/prefs_service_service.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../models/todo_model.dart';

class DashboardViewModel extends BaseViewModel {
  final PrefsServiceService _prefService = locator<PrefsServiceService>();
  final NavigationService navigator = locator<NavigationService>();
  final _themeService = locator<ThemetoggleService>();

  List<Todo> _todos = [];
  List get todos => _todos;

  bool get isDarkThemed => _themeService.isDark;

  List<String> categoryList = ["Work", "Personal", "Home", "Urgent", "Health"];

  String selectedCategory = "";

  String searchedText = "";
  TextEditingController serarchController = TextEditingController();

  List<String> todoList = ["study flutter", "study dart", "study stacked"];

  void getList() async {
    print("get list called");
    _todos = await PrefsServiceService.getTodos();

    print("todos list fetched $_todos");
    notifyListeners();
  }

  // Future<void> addList(List todos) async {
  //   await PrefsServiceService.addTodos();
  //   notifyListeners();
  // }

  void toggleTheme() {
    _themeService.toggleTheme();
    notifyListeners();
  }

  void setCategory(String cat) {
    selectedCategory = cat;
    notifyListeners();
  }

  void setSearch(String text) {
    searchedText = text;
  }

  void navigateToAddtaskview() {
    navigator.navigateTo(Routes.addtaskView);
  }
}
