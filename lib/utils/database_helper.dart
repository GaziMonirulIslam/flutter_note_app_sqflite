import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper/models/note.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }



  Future<Database> get database async {

    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }










// Open Database

   Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    
    var notesDatabase =  openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
 }



  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }



  // Fetch all note objects from database

     Future<List<Map<String, dynamic>>> getNoteMapLIst() async {
      Database db = await this.database;
      //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
      var result = await db.query(noteTable, orderBy: '$colPriority ASC');
      return result;
    }

    // Insert Operation


    Future<int> insertNote(Note note) async {
      
    Database db = await this.database;
    
    var result = await db.insert(noteTable, note.toMap());
    return result;
      
    }


    // Update operation


  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;

  }


  //Delete operation

 Future<int> deleteNote(int id) async {

    var db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
 }



// Get the Number of Objects in Database

  Future<int> getCount() async {

    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;

  }

  // Get the MAP from Database and conver to Note List


Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapLIst();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for(int i = 0; i<count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;

}

  
  

}