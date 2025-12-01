class Todo {
  String id;
  String title;
  String description;
  String isDone;
  List<String> categories;
  String createdAt;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.categories,
      required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'categories': categories,
      'createdAt': createdAt,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      categories: List<String>.from(json["categories"] ?? []),
      createdAt: json['createdAt'],
    );
  }
}
