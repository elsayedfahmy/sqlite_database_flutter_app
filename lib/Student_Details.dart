import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitedatabaseflutterapp/Model/Student.dart';
import 'package:sqlitedatabaseflutterapp/Utilities/Sql_helper.dart';

class Student_Details extends StatefulWidget{
  String screenTitle;
  Student student;
  Student_Details(this.student,this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    return _Student_Details(student,screenTitle);
  }

}
class _Student_Details extends State<Student_Details>{
  Sql_helper sql_helper=Sql_helper();
  String screenTitle;
  Student student;
  _Student_Details(this.student,this.screenTitle);

  static var _status=['sucessed','failed'];
  TextEditingController studentName_controller=TextEditingController();
  TextEditingController studentDetails_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    studentName_controller.text=student.name;
    studentDetails_controller.text=student.description;

    TextStyle textStyle=Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        print('back');
       return goBack(context);
      },
      child: Scaffold(
      appBar: AppBar(
          title:Text('$screenTitle'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: goBack(context),
        ),
    ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          ListTile(
            title: DropdownButton(
              items: _status.map((String item){
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              style:textStyle,
              value: getpassing(student.pass),
              onChanged: (item){
                setState(() {
                 // print('item is $item');
                  setpassing(item);
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: TextField(
              controller: studentName_controller,
              style: textStyle,
              onChanged: (value){
               // print('name:$value');
                student.name=value;
              },
              decoration: InputDecoration(
                labelText: 'name:',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: TextField(
              controller: studentDetails_controller,
              style: textStyle,
              onChanged: (value){
               // print('name:$value');
                student.description=value;
              },
              decoration: InputDecoration(
                  labelText: 'Description:',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
          ),
            Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Save',textScaleFactor: 1,),
                      onPressed: (){
                        setState(() {
                         // print('Save');
                          _saveStudent(context);
                        });
                      },



                    ),
                  ),
                  Container(width: 5,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Delete',textScaleFactor: 1,),
                      onPressed: (){
                        setState(() {
                        //  print('delete');
                          delete_student(context);
                        });
                      },



                    ),
                  )
                ],
              ),

            )

        ],

        ),
      ),
    )
    );

  }

  void setpassing(String value){
    switch(value)
    {
      case 'sucessed': student.pass =1;

        break;
      case 'failed':  student.pass =2;
      break;
      default: student.pass =1;
    }

  }
  String getpassing(int value){
    String pass;
    switch(value)
    {
      case 1: pass =_status[0];

      break;
      case 2:  pass =_status[1];
      break;
    }
    return pass;

  }

  Future<void> _saveStudent(BuildContext context) async {
    student.date = "";
    int result;
    if(student.id==null){
      result =await  sql_helper.insert_Student(student);
    }else {
      result=await sql_helper.update_Student(student);
    }
    if(result==0){
      ShowAlertdiakog('sorry', 'student not saved');
    }else{
      ShowAlertdiakog('Done', 'student saved');
      Navigator.canPop(context);
    }

  }

void ShowAlertdiakog(String title,String msg){
    AlertDialog alertDialog=AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog( context: null,builder: (_)=>alertDialog);
}

void delete_student(BuildContext context)async{
    if(student.id==null){
      ShowAlertdiakog('sorry', 'student not deleted');
      return;
    }
   int result =await  sql_helper.update_Student(student);
   if(result==0){
     ShowAlertdiakog('sorry', 'student not deleted');
   }else{
     ShowAlertdiakog('Done', 'student Deleted');
     Navigator.canPop(context);
   }
}
  goBack(BuildContext context){
    Navigator.pop(context);
}

}