import 'package:flutter/material.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:realtodo/services/prefs_service_service.dart';
import 'package:realtodo/services/resend_service.dart';
import 'package:realtodo/services/supabase_service.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/todo_model.dart';

class DashboardViewModel extends BaseViewModel {
  final PrefsServiceService _prefService = locator<PrefsServiceService>();
  final NavigationService navigator = locator<NavigationService>();
  final _themeService = locator<ThemetoggleService>();
  final _supaBaseService = locator<SupabaseService>();
  final _reSendService = locator<ResendService>();

  List<Todo> _todos = [];
  List get todos => _todos;

  bool get isDarkThemed => _themeService.isDark;

  List<String> categoryList = ["Work", "Personal", "Home", "Urgent", "Health"];

  String selectedCategory = "";

  String searchedText = "";
  TextEditingController searchController = TextEditingController();

  String totalTasks = "";
  String completedTasks = "";
  String pendingTasks = "";

  List<int> expandedList = [];

  bool isSwitchInteracting = false;

  void onSwitchStart() => isSwitchInteracting = true;
  void onSwitchEnd() => isSwitchInteracting = false;

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
    setBusy(true);
    _todos = await _supaBaseService.fetchTodos();
    setBusy(false);
    print("todos list fetched $_todos");
    print("todos list fetched: ${_todos.map((t) => t.title).toList()}");

    notifyListeners();
  }

  void deleteList(String id) async {
    print("to del id $id");
    await _supaBaseService.deleteTodo(id);
    getList();
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
    _todos = await _supaBaseService.fetchTodos();
    List<Todo> filtered = _todos
        .where((ele) => ele.categories.contains(selectedCategory))
        .toList();
    _todos = filtered;
    notifyListeners();
  }

  void setSearch(String text) async {
    print("searched text $text");
    _todos = await _supaBaseService.fetchTodos();
    searchedText = text;
    List<Todo> filtered =
        _todos.where((ele) => ele.title.contains(searchedText)).toList();
    _todos = filtered;
    notifyListeners();
  }

  void navigateToAddtaskview() async {
    await navigator.navigateTo(Routes.addtaskView,
        arguments: const AddtaskViewArguments(isEditing: false));

    getTaskStatus();
  }

  void getTaskStatus() async {
    print("get taskstatus haas been called");
    _todos = await _supaBaseService.fetchTodos();
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

  void toggleStatus(bool value, int index, String id) async {
    todos[index].isDone = value ? "Completed" : "Pending";
    String currentStatus = todos[index].isDone;
    await _supaBaseService.updateStatus(currentStatus, id);
    getTaskStatus();
    if (currentStatus == "Completed") {
      await _reSendService.sendEmail();
    }
  }

  void logOut() async {
    await Supabase.instance.client.auth.signOut();
    navigator.clearStackAndShow(Routes.loginView);
  }
}
