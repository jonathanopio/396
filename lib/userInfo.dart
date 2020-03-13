import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';


class userInfo {  
   
   userInfo()
   {
     
     
      
   }
  String classeOptions='';
  String classes;
  final Firestore db = Firestore.instance;
  BaseAuth auth;
   // Getters 
     
   String getClasses(){
     return classes;
   }
   String getClasseOptions(){
     return classeOptions;
   }
   // Updates 
   void updateAll() async{
     this.updateClass();
     this.updateClassOptions();
   }


   void updateClassOptions() async{ 
      String choices='';
    DocumentSnapshot stuff = await db.collection('classes').document('classOptions').get();
    Map<String, dynamic> newStuff =stuff.data;
    List<dynamic> k =newStuff['classes'];
    for(int i=0;i<k.length;i++)
    {
      choices += k[i]+" ";
    }
    classeOptions=choices;
   } 

   
    void updateClass() async{ 
      String choices='';
    DocumentSnapshot stuff = await db.collection('classes').document('classOptions').get();
    Map<String, dynamic> newStuff =stuff.data;
    List<dynamic> k =newStuff['classes'];
    for(int i=0;i<k.length;i++)
    {
      choices += k[i]+" ";
    }
    classeOptions=choices;
   }

   void addClass(String newClass) async
   {
     try {
    final FirebaseUser user = await auth.getCurrentUser(); 
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
}