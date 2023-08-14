import 'package:flutter/material.dart';
import 'package:pgvala_user/QR/qr_scanner.dart';

class qr extends StatefulWidget {
  const qr({Key? key}) : super(key: key);

  @override
  State<qr> createState() => _qrState();
}

class _qrState extends State<qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerWidget()),
            );
          },
          child: Text('Open QR Scanner'),
        ),
      ),
    );
  }
}
