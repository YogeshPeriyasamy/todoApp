import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/services/prefs_service_service.dart';
import 'package:stacked/stacked.dart';
import '../../../models/todo_model.dart';

class DashboardViewModel extends BaseViewModel {
  final PrefsServiceService _prefService = locator<PrefsServiceService>();

  List<Todo> _todos = [];
  List get todos => _todos;

  bool isDarkThemed = false;

  List<String> categoryList = ["Work", "Personal", "Home", "Urgent", "Health"];

  String selectedCategory = "";

  String searchedText = "";
  TextEditingController serarchController = TextEditingController();

  List<String> todoList = ["study flutter", "study dart", "study stacked"];

  void getList() async {
    _todos = await PrefsServiceService.getTodos();
    notifyListeners();
  }

  Future<void> addList(List todos) async {
    await PrefsServiceService.addTodos();
    notifyListeners();
  }

  void toggleTheme() {
    isDarkThemed = !isDarkThemed;
    notifyListeners();
  }

  void setCategory(String cat) {
    selectedCategory = cat;
    notifyListeners();
  }

  void setSearch(String text) {
    searchedText = text;
  }
}
