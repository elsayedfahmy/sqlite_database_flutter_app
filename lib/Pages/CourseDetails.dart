import 'package:flutter/material.dart';


class CourseDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseDetails();
  }

}
class _CourseDetails extends State<CourseDetails>{
  String name,content;
  int hours;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Details Course'),),
      body: null
    );
  }

}