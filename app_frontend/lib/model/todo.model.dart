class Todo {
  int? id;
  String? title;

  Todo({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': title,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(id: json['title'], title: json['title']);
  }
  dynamic toJson() => {'id': DateTime.now(), 'title': title};
}
