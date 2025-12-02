import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/todo_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await _client
          .from("todolist")
          .select()
          .order("created_at", ascending: true);
      print("response from fetchtodo $response");
      final List dataList = response as List;
      return dataList.map((ele) => Todo.fromJson(ele)).toList();
    } catch (err) {
      print("error while fetchifn list $err");
      return [];
    }
  }

  Future<void> addTodo(Todo newTodo) async {
    try {
      await _client.from("todolist").insert(newTodo.toJson());
    } catch (err) {
      print("err in adding newTodo $err");
    }
  }

  Future<void> updateTodo(Todo updatedTodo, String? id) async {
    try {
      if (id != null) {
        await _client
            .from("todolist")
            .update(updatedTodo.toJson())
            .eq('id', id);
      }
    } catch (err) {
      print("err in adding newTodo $err");
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _client.from("todolist").delete().eq("id", id);
    } catch (err) {
      print("error in deleting the lsit $err");
    }
  }
}
