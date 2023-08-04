import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

const String columnId = '_id';
const String columnTitle = 'title';
const String columnContent = 'Content';
const String columnDatecreate = 'Datecreate';
const String columnFixdate = 'Fixdate';
const String tableNotes = 'notes';

class Notes {
  int? id;
  String? title;
  String? content;
  DateTime? dateCreate;
  DateTime? fixDate;

  Notes({
    this.id,
    this.title,
    this.content,
    this.dateCreate,
    this.fixDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnContent: content,
      columnFixdate: fixDate?.toIso8601String(),
      columnDatecreate: dateCreate?.toIso8601String(),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static List<Notes> fromMaps(List<Map<String, dynamic>> maps) {
    List<Notes> notesList = [];
    for (var map in maps) {
      notesList.add(Notes(
          id: map[columnId],
          title: map[columnTitle],
          content: map[columnContent],
          dateCreate: null,
          fixDate: null));
    }
    return notesList;
  }
}

class NotesProvider with ChangeNotifier {
  List<Notes>? noteList;
  static Database? _database;
  bool hasNotes = false;

  static Future<Database> getInstance() async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute('''
        create table $tableNotes (
        $columnId integer primary key autoincrement,
        $columnTitle text DEFAULT "",
        $columnContent text DEFAULT "",
        $columnDatecreate text DEFAULT "",
        $columnFixdate text DEFAULT ""
        )
        ''');
      },
      version: 1,
    );

    String databasePath = _database?.path ?? " ";
    print("Database path: $databasePath");

    return _database!;
  }

  Future<void> insertNote(Notes notes) async {
    final db = await getInstance();
    int i = await db.insert(tableNotes, notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    log(i.toString());
  }

  Future<List<Notes>> getNotes() async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query(tableNotes);
    hasNotes = true;
    notifyListeners();
    return noteList = Notes.fromMaps(maps);
  }

  Future<List<Notes>> getDetail(int id) async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps =
        await db.query(tableNotes, where: "$columnId = $id");
    return Notes.fromMaps(maps);
  }

  Future<int> update(Notes notes) async {
    final db = await getInstance();
    return await db.update(tableNotes, notes.toMap(),
        where: "$columnId = ${notes.id}");
  }

  Future<List<Notes>> getSearch(String searchKey) async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query(tableNotes,
        where: ' $columnTitle LIKE ?}', whereArgs: ['%$searchKey%']);
    return Notes.fromMaps(maps);
  }

  Future<int> delete(Notes notes) async {
    final db = await getInstance();
    return await db.delete(tableNotes, where: '$columnId =${notes.id}');
  }
}
