import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
class Notes{
  int? id;
  String? title;
  String? content;
  DateTime? dateCreate;
  DateTime? fixDate;
  Notes({this.id, this.title, this.content, this.dateCreate, this.fixDate});
}
class NotesDatabase{
  static Database? _database;
  static Future<Database> getInstance() async{
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes( id INTEGER PRIMARY KEY, title TEXT, content Text, dateCreate NUMERIC, fixDate NUMERIC )'
        );
      },
      version: 1,
    );

    return _database!;
  }
  Future<void> insertNote(Map<String, dynamic> note) async {
    final db = await getInstance();
    await db.insert('notes', note,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  }


// class DatabaseNotes extends StatefulWidget {
//   const DatabaseNotes({super.key});
//
//   @override
//   State<DatabaseNotes> createState() => _DatabaseNotesState();
// }

// class _DatabaseNotesState extends State<DatabaseNotes> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   void get()async{
//
//     final result = await getDatabasesPath();
//     print(result);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
