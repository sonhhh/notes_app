import 'package:app_note/sqlline/database_notes.dart';
import 'package:flutter/material.dart';
class MakeNotes extends StatefulWidget {
  const MakeNotes({super.key});

  @override
  State<MakeNotes> createState() => _MakeNotesState();
}

class _MakeNotesState extends State<MakeNotes> {
  late  TextEditingController _controller = TextEditingController();
  final NotesDatabase notesDatabase = NotesDatabase();
  void insertDataToDatabase() async {
    try {
      await notesDatabase.insertNote({
        'title': 'Ghi chú mới',
        'content': 'Nội dung ghi chú',
        'dateCreate': DateTime.now().toString(),
        'fixDate': DateTime.now().toString(),
      });
    } catch (e) {
      print('Error inserting data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(37, 37, 37, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(59, 59, 59, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(59, 59, 59, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 25,
                  ),
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(59, 59, 59, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.save_outlined,
                    size: 25,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const TextField(
              autofocus: true,
            maxLines: null,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: TextStyle(
                color: Colors.white38,
                fontSize: 48,

              )
            ),
          ),
          const TextField(
            autofocus: true,
            maxLines: null,
            style: TextStyle(
                color: Colors.white,
                fontSize: 23
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type something...',
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 23,

                )
            ),
          )
        ],
      ),
    ));
  }
}
