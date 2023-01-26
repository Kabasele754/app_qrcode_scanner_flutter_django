import 'dart:convert';

import 'package:app_frontend/api/auth/api.auth.dart';
import 'package:app_frontend/model/todo.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final todoTitleController = TextEditingController();
  final todoDesController = TextEditingController();
  //TextEditingController controller = TextEditingController();

  //Client client = http.Client();

  List<Todo> todoes = [];

  QRViewController? controller;

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    _retrieveTodo();
    // TODO: implement initState
    super.initState();
  }

  _retrieveTodo() async {
    //get the toDo list
    todoes = [];
    //List repoonse = json.decoder((await client.get(retrieveUrl)).body);
  }

  void _addTodo() {}

  void onAdd() {
    final String textVal = todoTitleController.text;
    final String desVal = todoDesController.text;

    if (textVal.isNotEmpty) {
      final Todo todo = Todo(title: textVal);
      return Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
    }
  }

  // var client = http.Client();
  // this is the function scanne
  void addFuctionScanne(String title) async {
    //If you're making multiple requests to the same server, you can keep open a
    //persistent connection by using a Client rather than making one-off requests.
    //If you do this, make sure to close the client when you're done:
    Client client = http.Client();
    try {
      var response = await client.post(
          Uri.https('trutmereport.pythonanywhere.com', 'apis/qrcode/'),
          body: {'title': title}); //todoTitleController.text
      print("Voir response $response");
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print("Montre moi $decodedResponse");
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } finally {
      // this client close for to send one request to our server
      client.close();
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Add Todo')),
  //     body: ListView(
  //       children: [
  //         Container(
  //             child: Column(
  //           children: [
  //             TextField(
  //               controller: todoTitleController,
  //             ),
  //             // TextField(
  //             //   controller: todoDesController,
  //             // ),
  //             ElevatedButton(
  //                 child: Text('Add'),
  //                 onPressed: () {
  //                   //onAdd();
  //                   add();
  //                   print("Il y a quoi ici $add()");

  //                   Navigator.of(context).pop();
  //                 })
  //           ],
  //         ))
  //       ],
  //     ),
  //   );
  // }

  // void onAdd(String? textVal) {
  //   //final String textVal = todoTitleController.text;
  //   // final String desVal = todoDesController.text;

  //   //if (textVal.isNotEmpty) {
  //   final Todo todo = Todo(
  //     title: textVal,
  //   );
  //   Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
  //   //}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      var scanData2 = scanData;
      // if (await canLaunch(scanData2.code.toString())) {
      //   await launch(scanData.code.toString());
      // onAdd(scanData.code.toString());
      // this function add it permet to save in our database
      addFuctionScanne(scanData.code.toString());
      print('Achille QRCODE WAPI 11111111 $scanData2.code.toString()');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //otion  dialog to show your scanne place
            title: Text('Your Scanne have succefully'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Barcode Type: ${describeEnum(scanData.format)}'),
                  Text('Site place : ${scanData.code}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  //onAdd(scanData.code);
                  print('Achille QRCODE WAPI $scanData.code');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).then((value) => controller.resumeCamera());

      controller.resumeCamera();
      //}
      // else {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text('Could not find viable url'),
      //         content: SingleChildScrollView(
      //           child: ListBody(
      //             children: <Widget>[
      //               Text('Barcode Type: ${describeEnum(scanData.format)}'),
      //               Text('Data: ${scanData.code}'),
      //             ],
      //           ),
      //         ),
      //         actions: <Widget>[
      //           TextButton(
      //             child: Text('Ok'),
      //             onPressed: () {
      //               //onAdd(scanData.code);
      //               print('Achille QRCODE WAPI $scanData.code');
      //               Navigator.of(context).pop();
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   ).then((value) => controller.resumeCamera());
      // }
    });
  }
}
