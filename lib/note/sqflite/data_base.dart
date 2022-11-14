import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:xsphere_code_test_prototype/note/sqflite/note_model.dart';

class NoteDatabase with ChangeNotifier {
  NoteDatabase? noteDatabase;
  Database? _database;
  String noteTable = 'note_table';
  String id = 'id';
  String dateTime = 'date_time';
  String note = 'note';

  NoteDatabase._createInstance();

  factory NoteDatabase() {
    NoteDatabase._createInstance();
    return NoteDatabase._createInstance();
  }
  Future<Database?> get database async {
    _database = await initializedDatabase();
    return _database;
  }

  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}note_database.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($id INTEGER PRIMARY KEY,$dateTime TEXT, $note TEXT)');
  }

  Future<List<NoteModel>> getData() async {
    Database? db = await database;
    var result = await db!.rawQuery('SELECT * FROM $noteTable');
    return result.map((e) => NoteModel.fromMapObject(e)).toList();
  }

  Future<int> insertData(NoteModel note) async {
    Database? db = await database;
    var result = await db!.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateData(NoteModel note) async {
    Database? db = await database;
    var result = await db!
        .update(noteTable, note.toMap(), where: 'id= ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteData(int id) async {
    Database? db = await database;
    var result = await db!.delete(noteTable, where: "id = ?", whereArgs: [id]);
    debugPrint('$result');
    return result;
  }
}
