import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class PrefsServiceService {
  static String listName = "todoList";

  static Future<void> addTodos() async {}

  static Future<List<Todo>> getTodos() async {
    return [];
  }
}
