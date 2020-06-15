import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:sqlitedatabaseflutterapp/Model/Student.dart';

class Sql_helper {
  static Sql_helper db_helper;

  Sql_helper._createInstance();

  static Database _database;

  factory Sql_helper() {
    if (db_helper == null) {
      db_helper = Sql_helper._createInstance();
    }
    return db_helper;
  }

  final String tableName = 'student_table';
  final String _id = 'id';
  final String _name = 'name';
  final String _description = 'description';
  final String _pass = 'pass';
  final String _date = 'date';

  Future<Database> get databsae async {
    if (_database == null) {
      _database = await intilazation_Database();
    }
    return _database;
  }
  var database;
  Future<Database> intilazation_Database() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'students.db');
     database = await openDatabase(dbPath, version: 1, onCreate: createDatabase);
    return database;
  }

  void createDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
            "$_id INTEGER PRIMARY KEY AOTOINCREMENT," +
        "$_name TEXT," +
        "$_description TEXT," +
        "$_pass INTEGER" +
        "$_date TEXT" +
        ")");
  }

  //------------------------------------------------------------------------ read all Data
  //Future<List<Map<String,dynamic>>> get_students_maplist() async {
  Future<List> get_students_maplist() async {
    Database db=await this.databsae;
    //var result = await database.query(tableName, columns: ["id", "name", "description", "pass","date"]);
    var result = await db.rawQuery('SELECT * FROM $tableName');
   // return result.toList();
   // var result = await db.query(tableName, orderBy: "$_id ASC");

    return result.toList();
  }
//------------------------------------------------------------------------ read count of Data
//Future<List> get_studentsmaplist() async {
  Future<int> get_Count_of_Data() async {
    Database db=await this.databsae;
    var result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count=Sqflite.firstIntValue(result);
    return count;
  }
//------------------------------------------------------------------------ insert new student
  Future<int> insert_Student(Student student) async {
    Database db=await this.databsae;
   /*
    var result = await db.rawInsert(
      "INSERT INTO Customer (id,first_name, last_name, email)"
      " VALUES (${student.id},${student.name},${student.description},${student.pass},${student.date})");
   */
    var result = await db.insert(tableName, student.tomap());
    return result;
  }
  //------------------------------------------------------------------------ update student
  Future<int> update_Student(Student student) async {
    Database db=await this.databsae;
    return await db.update(tableName, student.tomap(), where: "$_id = ?", whereArgs: [student.id]);
  }
  //------------------------------------------------------------------------ delete student
  Future<int> delete_Student(int id) async {
    Database db=await this.databsae;
   // return await db.delete(tableName, where: '$_id = ?', whereArgs: [id]);
    return await db.rawDelete('DELETE FROM $tableName WHERE $_id = $id');
  }
  Future close() async => database.close();
}
