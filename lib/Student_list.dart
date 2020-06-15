import 'package:flutter/material.dart';
import 'package:sqlitedatabaseflutterapp/Student_Details.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitedatabaseflutterapp/Model/Student.dart';
import 'package:sqlitedatabaseflutterapp/Utilities/Sql_helper.dart';

class Student_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Student_list();
  }
}

class _Student_list extends State<Student_list> {
  int count = 0;
 Sql_helper sql_helper=Sql_helper();
 List<Student> student_list;

  @override
  Widget build(BuildContext context) {
    if(student_list == null){
      student_list=List<Student>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Students '),
      ),
      body: get_Student_list(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Student_Details(Student('','',0,''),'student');
          }));
          updateListView();
        },
        tooltip: 'Add Student',
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }

  ListView get_Student_list() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blue,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ispass_color(this.student_list[index].pass),
              child: geticon(this.student_list[index].pass),
            ),
            title: Text(this.student_list[index].name),
            subtitle: Text(this.student_list[index].description+""+this.student_list[index].date),
            trailing: GestureDetector(
             child: Icon(Icons.delete, color: Colors.blue,),
              onTap: deleteItem(context,this.student_list[index]),
            )

            ,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Student_Details( this.student_list[index],'student');
              }));
            },
          ),
        );
      },
    );
  }

 Color ispass_color(int value){
    switch(value){
      case 1: return Colors.amber;
        break ;
      case 2:return Colors.red;
        break ;
      default:return Colors.amber;
    }
  }
 Icon geticon(int value){
    switch(value){
      case 1:return Icon( Icons.check);
      break ;
      case 2:return Icon(Icons.close);
      break ;
      default:return Icon( Icons.check);;
    }
  }
  deleteItem(BuildContext context,Student  student )async{
    int rows= await sql_helper.delete_Student(student.id);
    if (rows!=0){
      //----------------------
      updateListView();
      _showSnakbar(context, "Deleted");

    }
  }
_showSnakbar(BuildContext context ,String msg){
    var snackbar =SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackbar);

}

void updateListView() {
   Future<Database> db=sql_helper.intilazation_Database();
   db.then((database) {
  Future<List<Student>> students= sql_helper.get_students_maplist();
  students.then((thelist) {
    setState(() {
      this.student_list=thelist;
      this.count=thelist.length;
    });

  });
   });
}
  
  
  }


