import 'package:app_frontend/api/auth/api.auth.dart';
import 'package:app_frontend/model/todo.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final todoTitleController = TextEditingController();
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onAdd(String? textVal) {
    //final String textVal = todoTitleController.text;
    // final String desVal = todoDesController.text;

    //if (textVal.isNotEmpty) {
    final Todo todo = Todo(
      title: textVal,
    );
    Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
    //}
  }

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
      if (await canLaunch(scanData2.code.toString())) {
        await launch(scanData.code.toString());
        onAdd(scanData.code.toString());
        print('Achille QRCODE WAPI 11111111 $scanData.code');

        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    onAdd(scanData.code);
                    print('Achille QRCODE WAPI $scanData.code');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}
