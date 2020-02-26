import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_base/authentication.dart';

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     ));

class QRPage extends StatefulWidget {
  @override
  QRPageState createState() {
    return new QRPageState();
  }
}

class QRPageState extends State<QRPage> {
  String result = "Hey there !";
  static Firestore db = Firestore.instance;
  
  String qr;
  
  String time;

  var docRef = db.collection('qr'); 
  Future _scanQR() async {
    
    
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        db.collection('qr').document('scannedQR').setData({
          //add user who sent
          'qr' : qrResult,
          'time' : new DateTime.now()
        });
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}