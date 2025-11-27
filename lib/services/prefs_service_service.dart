import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class PrefsServiceService {
  static String listName = "todoList";

  static Future<void> addTodos(Todo newTodo) async {
    final todos = await getTodos(); // fetch existing first
    print("old todos in service $todos");
    print("new todo $newTodo");
    todos.add(newTodo);
    final jsonList = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    print("json list to add $jsonList");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listName, jsonList);
  }

  static Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();

    //fetching the list from prefs
    final jsonList = prefs.getStringList(listName);

    if (jsonList == null) return [];

    return jsonList
        .map((taskStr) => Todo.fromJson(jsonDecode(taskStr)))
        .toList();
  }

  static Future<void> deleteTodos(int ind) async {
    print("to delete in service $ind");
    final todos = await getTodos();
    print("todos before del $todos");
    todos.removeAt(ind);
    print("todos after del $todos");
    final jsonList = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listName, jsonList);
  }
}
