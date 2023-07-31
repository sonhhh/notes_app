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
      columnDatecreate: dateCreate,
      columnFixdate: fixDate,
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
        dateCreate: DateTime.fromMillisecondsSinceEpoch(map[columnDatecreate]),
        fixDate: map[columnFixdate] != null
            ? DateTime.fromMillisecondsSinceEpoch(map[columnFixdate])
            : null,
      ));
    }
    return notesList;
  }
}

class NotesProvider {
  static Database? _database;

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
        $columnTitle text not null,
        $columnContent text not null,
        $columnDatecreate integer not null,
        $columnFixdate integer
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
    await db.insert(tableNotes, notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Notes>>getNotes() async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query(tableNotes);
    return Notes.fromMaps(maps) ;
  }
}

//   Future open(String path) async {
//     db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
// create table $tableNotes (
//   $columnId integer primary key autoincrement,
//   $columnTitle text not null,
//   $columnContent text not null,
//   $columnDatecreate number not null,
//   $columnFixdate number
//   )
// ''');
//       },
//     );
//   }
//
//   Future<Notes> insert(Notes notes) async {
//     notes.id = await db?.insert(tableNotes, notes.toMap());
//     return notes;
//   }

// class NotesDatabase{
//   static Database? _database;
//   static Future<Database> getInstance() async{
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'notes.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE notes( id INTEGER PRIMARY KEY, title TEXT, content Text, dateCreate NUMERIC, fixDate NUMERIC )'
//         );
//       },
//       version: 1,
//     );
//
//     return _database!;
//   }
// Future<void> insertNote(Map<String, dynamic> note) async {
//   final db = await getInstance();
//   await db.insert('notes', note,
//       conflictAlgorithm: ConflictAlgorithm.replace);
// }

// }

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
