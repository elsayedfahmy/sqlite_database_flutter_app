import 'package:flutter/material.dart';
import 'package:sqlitedatabaseflutterapp/Pages/NewCourse.dart';


class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }

}
class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('SQLITE DATABASE'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (c)=>NewCourse()));
          },
        )
      ],),
      body: null,
    );
  }

}