

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'qr.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  
  

  @override
  State<StatefulWidget> createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {
static Firestore db = Firestore.instance;
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
    _addClass(String newClass) async { ///Update bad names
    try {
    final FirebaseUser user = await widget.auth.getCurrentUser(); 
    final String name = user.email;
    DocumentSnapshot stuff = await db.collection('userProfile').document(name).get();
    Map<String, dynamic> newStuff =stuff.data;
     List<dynamic> k =newStuff['classes'];
     bool b=true;
     if(k!=null){
     for(int i=0; i<k.length;i++)// looks through to see if class exists already before adding
     {
       if(k[i]==newClass)
       {
        b=false;
       }
     }
    if(b){
    db.collection('userProfile').document(name)
                    .setData({
                  'name' : name,
                  "classes": (k+[newClass])
    }).catchError((err) => print(err));
    }}else{db.collection('userProfile').document(name)
                    .setData({
                  'name' : name,
                  "classes": ([newClass])
    }).catchError((err) => print(err));
    }

    }
    catch (e) {
      print(e);
    }
    
  }
  _removeClass(dynamic newClass) async { ///Update bad names
    try {
    final FirebaseUser user = await widget.auth.getCurrentUser(); 
    final String name = user.email;
    DocumentSnapshot stuff = await db.collection('userProfile').document(name).get();
    Map<String, dynamic> newStuff =stuff.data;
     List<dynamic> k =newStuff['classes'];
     
     List<dynamic> updatedClasses =[];
     for(int i=0; i<k.length;i++)// looks through to see if class exists already before adding
     {
       if(k[i]!=newClass)
       {
        updatedClasses.add(k[i]);
       }
     }
    
    db.collection('userProfile').document(name)
                    .updateData({
                  'name' : name,
                  "classes": (updatedClasses)
    }).catchError((err) => print(err));
    }
    catch (e) {
      print(e);
    }
    
  }
String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Attendance App'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut),
        ],
        
      ),

      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.deepPurple
    ),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
      });
    },
    items: <String>['One', 'Two', 'Free', 'Four']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  ),
          RaisedButton(
            child: Text('add class'),
            onPressed: () {
              _addClass(dropdownValue);
            },
          ),
          RaisedButton(
            child: Text('View classes'),
            onPressed: () {
              Null;
            },
          ),
          RaisedButton(
            child: Text('edit '),
            onPressed: () {
              Null;
            },
          ),
          RaisedButton(
            child: Text('Delete class'),
            onPressed: () {
              _removeClass(dropdownValue);
            },
          ),
        ],
      )),
      
            
      
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.center_focus_weak),
        label: Text("Scan"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QRPage()));
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      

    );
  }
}