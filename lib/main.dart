import 'package:flutter/material.dart';
import 'package:sqlitedatabaseflutterapp/Pages//Home.dart';
import 'package:sqlitedatabaseflutterapp/Student_list.dart';
import 'package:sqlitedatabaseflutterapp/Student_Details.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primarySwatch: Colors.cyan),
      home: Student_list(),
    );
  }

}