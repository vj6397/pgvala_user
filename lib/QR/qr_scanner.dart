
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgvala_user/Api/requestUtil.dart';
import 'package:pgvala_user/Navigate/navigate.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class QRScannerWidget extends StatefulWidget {
  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";
  List<dynamic> jsonData=[];
  late String status='status';
  // late String accid='';

  void qr_result(String qr_text)async {
    RequestUtil util=new RequestUtil();
    http.Response res=await util.qrResult(qr_text);
    if(res.statusCode==200){
      print(res.body);
      jsonData=jsonDecode(res.body);
      print(jsonData[0]["result"]);
      print(jsonData[0]["accid"]);
      setState(() {
        if(jsonData[0]["result"]==1) status='Available';
        else status='not available';
      });
      // accid=jsonData[0]["accid"];
    }
    else print(res.body);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Availability'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Rooms are $status',style: TextStyle(
                fontSize: 15
              ),),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
        qr_result(qrText);
      });
    });
  }
}
