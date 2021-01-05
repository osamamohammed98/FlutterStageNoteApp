import 'dart:io';

import 'package:note_stage_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HELPSqlite {
  HELPSqlite._();

  static HELPSqlite helpSqlite = HELPSqlite._();
  Database database;
  static String DB_Table_NAME = "NoteTask";
  static String DB_Table_ID_COL = "id";
  static String DB_Table_TITLE_COL = "title";
  static String DB_Table_CONTENT_COL = "content";
  static String DB_Table_DATE_COL = "date_created";
  static String DB_Table_COLOR_COL = "note_color";

  initDataBase() async {
    if (database == null) {
      database = await createDataBase();
    }
    return database;
  }

  Future<Database> createDataBase() async {
    Directory directoryPath = await getApplicationDocumentsDirectory();
    String dbpath = join(directoryPath.path, "note_task.db");
    Database db = await openDatabase(dbpath,
        onCreate: (db, version) => createDatabase(db, version), version: 1);

    return db;
  }

  createDatabase(Database db, int version) {
    db.execute('''
    CREATE TABLE $DB_Table_NAME (
    $DB_Table_ID_COL INTEGER PRIMARY KEY AUTOINCREMENT,
    $DB_Table_TITLE_COL TEXT,
    $DB_Table_CONTENT_COL TEXT,
    $DB_Table_DATE_COL TEXT,
    $DB_Table_COLOR_COL INTEGER
    )
    ''');
  }

  insertToDatabase(Note note) async {
    try {
      await database.insert(DB_Table_NAME, note.toMap());
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  updateDatabase(Note note) async {
    try {
      await database.update(DB_Table_NAME, note.toMap(),
          where: "$DB_Table_ID_COL=?", whereArgs: [note.id]).whenComplete(() => print("doneUpdate"));
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  deleteFromDatabase(Note note) async {
    try {
      await database
          .delete(DB_Table_NAME, where: "$DB_Table_ID_COL=?", whereArgs: [note.id]);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> selectAllFromDataBase() async {
    try {
      List<Map<String, dynamic>> query = await database.query(DB_Table_NAME);
      return query;
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  selectOneFromDataBase(Note note) async {
    try {
      List<Map<String, dynamic>> query = await database
          .query(DB_Table_NAME, where: "$DB_Table_ID_COL=?", whereArgs: [note.id]);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }
}
