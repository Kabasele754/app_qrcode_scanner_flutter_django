import 'dart:convert';
import 'package:app_frontend/model/todo.model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://trutmereport.pythonanywhere.com";

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  TodoProvider() {
    // this.fetchTasks();
  }
  void addTodo(Todo todo) async {
    // final response = await http.post('http://10.0.2.2:8000/apis/v1/';
    var url = Uri.https('trutmereport.pythonanywhere.com', 'apis/qrcode/');

    //                 client.post(url, body: {'body': controller.text});

    // var url =
    //     Uri.https('https://trutmereport.pythonanywhere.com', 'apis/qrcode/');
    var response = await http.post(url, body: todo);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));

    // var url = Uri.parse("$baseUrl/apis/qrcode/");
    // Map body = {"body": todo};
    // var response = await http.post(url, body: body);
    // print(response.body);

    // headers: {"Content-Type": "application/json"}, body: json.encode(todo));
    //201
    if (response.statusCode == 201) {
      todo.id = json.decode(response.body)['id'];
      _todos.add(todo);
      // notifyListeners();
    }
  }

  // fetchTasks() async {
  //   final url = 'http://10.0.2.2:8000/apis/v1/?format=json';
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body) as List;
  //     _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
  //     notifyListeners();
  //   }
  // }
}

// class TodoProvider with ChangeNotifier {
//   TodoProvider() {
//     // this.fetchTasks();
//   }

//   List<Todo> _todos = [];

//   List<Todo> get todos {
//     return [..._todos];
//   }

//   void addTodo(Todo todo) async {
//     // final response = await http.post('$baseUrl/apis/qrcode/?format',
//     //     headers: {"Content-Type": "application/json"}, body: json.encode(todo));

//     var url = Uri.parse("$baseUrl/apis/qrcode/?format");
//     //Map body = {"body": todo};
//     var response = await http.post(url,
//         headers: {"Content-Type": "application/json"}, body: json.encode(todo));

//     if (response.statusCode == 201) {
//       todo.id = json.decode(response.body)['id'];
//       print('Voir TODOTOTODODTODTODTODTODTODTODTODTDO$response.body');
//       _todos.add(todo);
//       notifyListeners();
//     }
//   }

//   // fetchTasks() async {
//   //   var url = 'http://10.0.2.2:8000/apis/v1/?format=json';
//   //   var response = await http.get(url);
//   //   if (response.statusCode == 200) {
//   //     var data = json.decode(response.body) as List;
//   //     _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
//   //     notifyListeners();
//   //   }
//   // }
// }
