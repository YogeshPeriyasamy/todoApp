import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:realtodo/services/supabase_service.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/todo_model.dart';
import 'dart:math'; // to generate random id

class AddtaskViewModel extends BaseViewModel {
  final ThemetoggleService _themeService = locator<ThemetoggleService>();
  final navService = locator<NavigationService>();
  final supaBaseService = locator<SupabaseService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get isDark => _themeService.isDark;

  String? toUpdateId;

  List<String> selectedCategories = [];
  List<String> categories = ["Health", "Personal", "Home", "Urgent", "Work"];

  final currentUserId = Supabase.instance.client.auth.currentUser?.id;

  void setCategory(category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }

  String status = "Pending";
  List<String> statusList = ["Pending", "Completed"];
  void setStatus(stat) {
    status = stat;
  }

  Future<void> addOrEditTask() async {
    final title = titleController.text;
    final description = descriptionController.text;
    print(title);
    print(description);
    print(status);

    //generate random id
    final random = Random();
    String taskId = random.nextInt(1000000).toString();

    Todo newTodo = Todo(
        id: taskId,
        title: title,
        description: description,
        isDone: status,
        categories: selectedCategories,
        createdAt: DateTime.now(),
        userId: currentUserId,
        );

    if (toUpdateId == null) {
      await supaBaseService.addTodo(newTodo);
    } else {
      await supaBaseService.updateTodo(newTodo, toUpdateId);
      toUpdateId = null;
    }
    titleController.clear();
    descriptionController.clear();
    navService.clearStackAndShow(Routes.dashboardView);
  }

  Future<void> initialize(Todo? todo, int? index, bool isEditing) async {
    if (todo != null && index != null) {
      toUpdateId = todo.id;
      titleController.text = todo.title;
      descriptionController.text = todo.description;
      selectedCategories = List.from(todo.categories);
      status = todo.isDone.trim();
      notifyListeners();
    }
  }

  void navBacktoDashboard() {
    navService.clearStackAndShow(Routes.dashboardView);
  }
}
