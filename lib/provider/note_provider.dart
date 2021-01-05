import 'package:flutter/foundation.dart';
import 'package:note_stage_app/model/note_model.dart';
import 'package:note_stage_app/model/sqlite_helper.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];

  fillLists(List<Note> note) {
    this.notes = note;
    notifyListeners();
  }

  Future insertToDatabase(Note note) async {
    await HELPSqlite.helpSqlite.insertToDatabase(note);
    //todo get all notes
    selecteAllFromDatabase();
  }

  Future updateDatabase(Note note) async {
    await HELPSqlite.helpSqlite.updateDatabase(note);
    //todo get all notes
    selecteAllFromDatabase();
  }

  Future deleteFromDatabase(Note note) async {
    await HELPSqlite.helpSqlite.deleteFromDatabase(note);
    //todo get all notes
    selecteAllFromDatabase();
  }

  selecteAllFromDatabase() async {
    List<Map<String, dynamic>> rowOfNote =
        await HELPSqlite.helpSqlite.selectAllFromDataBase();

    List<Note> notesList =
        rowOfNote != null ? rowOfNote.map((e) => Note.fromMap(e)).toList() : [];
    fillLists(notesList);
  }

  selectOnFromDatabase(Note note) async {
    await HELPSqlite.helpSqlite.selectOneFromDataBase(note);
    selecteAllFromDatabase();
  }
}
