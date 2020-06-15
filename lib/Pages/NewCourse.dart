import 'package:flutter/material.dart';


class NewCourse extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewCourse();
  }

}
class _NewCourse extends State<NewCourse>{
  String name,content;
  int hours;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('New Course'),),
      body:
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Ernter your name',
              ),
              onChanged: (value){
                setState(() {
                  name=value;
                });

              },
            ),
            SizedBox(height: 5,),
            TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Ernter Course content ',
              ),
              onChanged: (value){
                setState(() {
                  content=value;
                });

              },
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ernter number of hours',
              ),
              onChanged: (value){
                setState(() {
                  hours=int.parse(value);
                });

              },
            ),
            SizedBox(height: 5,),
            RaisedButton(
              child: Text('Save'),
              onPressed: ()=>null,
            )
          ],),
        ),
      ),
    );
  }

}