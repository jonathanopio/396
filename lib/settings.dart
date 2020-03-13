import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:qr_base/userInfo.dart';
import 'authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_base/authentication.dart';
import 'userInfo.dart';

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     ));

class settings extends StatefulWidget {
  var userData = new userInfo();
  settings(var data)
  {
    userData=data;
  }
  @override
  settingsState createState() {
    return new settingsState(userData);
  }
}

class settingsState extends State<settings> {
  var userData = new userInfo();
  String result= "didn't change";
  settingsState(var data)
  {
    userData=data;
    result = userData.getClasseOptions();
  }
  
  static Firestore db = Firestore.instance;
  
  String qr;
  
  String time;

  var docRef = db.collection('qr'); 
  _blank()
  {

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings"),
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
        onPressed: _blank,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}