import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/prefs_service_service.dart';
import '../../../models/todo_model.dart';
import 'dart:math'; // to generate random id

class AddtaskViewModel extends BaseViewModel {
  final ThemetoggleService _themeService = locator<ThemetoggleService>();
  final navService = locator<NavigationService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get isDark => _themeService.isDark;

  String selectedCategory = "Work";
  List<String> categories = ["Work", "Personal", "Home", "Urgent", "Health"];
  void setCategory(category) {
    selectedCategory = category;
  }

  String status = "Pending";
  List<String> statusList = ["Pending", "Completed"];
  void setStatus(stat) {
    status = stat;
  }

  Future<void> addTask() async {
    final title = titleController.text;
    final description = descriptionController.text;
    print(title);
    print(description);
    print(selectedCategory);
    print(status);
    titleController.clear();
    descriptionController.clear();

    //generate random id
    final random = Random();
    String taskId = random.nextInt(1000000).toString();

    Todo newTodo = Todo(
        id: taskId,
        title: title,
        description: description,
        isDone: status,
        category: selectedCategory,
        createdAt: DateTime.now().toString());

    await PrefsServiceService.addTodos(newTodo);
    navService.navigateTo(Routes.dashboardView);
  }

  void initialize(Todo? todo, int? index, bool isEditing) {
    if (todo != null) {
      titleController.text = todo.title;
      descriptionController.text = todo.description;
      selectedCategory = todo.category;
      status = todo.isDone;
    }
  }
}
