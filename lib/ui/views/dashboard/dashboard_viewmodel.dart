import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:realtodo/services/prefs_service_service.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:realtodo/ui/views/addtask/addtask_view.dart';
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

  String totalTasks = "";
  String completedTasks = "";
  String pendingTasks = "";

  List<int> expandedList = [];

  void toExpandList(int index) {
    if (expandedList.contains(index)) {
      expandedList.remove(index);
    } else {
      expandedList.add(index);
    }
    notifyListeners();
  }

  Future<void> getList() async {
    print("get list called");
    _todos = await PrefsServiceService.getTodos();

    print("todos list fetched $_todos");
    print("todos list fetched: ${_todos.map((t) => t.title).toList()}");

    notifyListeners();
  }

  void deleteList(int index) async {
    print("to del index $index");
    await PrefsServiceService.deleteTodos(index);
    _todos = await PrefsServiceService.getTodos();
    getTaskStatus(); //manually updating the list
    notifyListeners();
  }

  void editList(Todo toEditTodo, int index) async {
    print("toeditto do to send in the add/editview ${toEditTodo.isDone}");
    await navigator.navigateTo(Routes.addtaskView,
        arguments: AddtaskViewArguments(
            isEditing: true, todo: toEditTodo, index: index));

    getTaskStatus();
  }

  void toggleTheme() {
    _themeService.toggleTheme();
    notifyListeners();
  }

  void setCategory(String cat) async {
    selectedCategory = cat;
    _todos = await PrefsServiceService.getTodos();
    List<Todo> filtered =
        _todos.where((ele) => ele.category == selectedCategory).toList();
    _todos = filtered;
    notifyListeners();
  }

  void setSearch(String text) async {
    print("searched text $text");
    _todos = await PrefsServiceService.getTodos();
    searchedText = text;
    List<Todo> filtered =
        _todos.where((ele) => ele.title.contains(searchedText)).toList();
    _todos = filtered;
    notifyListeners();
  }

  void navigateToAddtaskview() async {
    await navigator.navigateTo(Routes.addtaskView,
        arguments: AddtaskViewArguments(isEditing: false));

    getTaskStatus();
  }

  void getTaskStatus() async {
    print("get taskstatus haas been called");
    _todos = await PrefsServiceService.getTodos();
    int totalTasksLength = _todos.length;
    totalTasks = totalTasksLength.toString();

    int completedTasksLength = _todos
        .where((ele) {
          print("status ${ele.isDone}");
          return ele.isDone == "Completed";
        })
        .toList()
        .length;
    completedTasks = completedTasksLength.toString();

    pendingTasks = (totalTasksLength - completedTasksLength).toString();
    notifyListeners();
  }
}
