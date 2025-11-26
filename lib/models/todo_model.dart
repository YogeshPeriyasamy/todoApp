class Todo {
  String id;
  String title;
  String description;
  String isDone;
  String category;
  String createdAt;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.category,
      required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'category': category,
      'createdAt': createdAt,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      category: json['category'],
      createdAt: json['createdAt'],
    );
  }
}
