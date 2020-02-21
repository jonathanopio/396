import 'package:flutter/material.dart';
import 'root_page.dart';
import 'loginsignuppage.dart';
import 'authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication AndroidVille',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RootPage(
        auth: new Auth(),
      ),
    );
  }
}