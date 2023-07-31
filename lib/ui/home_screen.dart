import 'package:app_note/sqlline/database_notes.dart';
import 'package:app_note/ui/make_notes.dart';
import 'package:app_note/ui/searching_note.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Notes>> notesList = NotesProvider().getNotes();
  //List<Notes> notesList =[];
  bool isNotes = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(color: Colors.white, fontSize: 43),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const SearchingNote();
                      },));
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'Designed by -',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Redesigned by -',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Illustrations -',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Icons -',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Font -',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Center(child: Text('Made by', style: TextStyle(
                                  color: Colors.white
                                ),)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      size: 25,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            isNotes ?
            const Column(
              children: [
                Center(
                    child: Image(
                  image: AssetImage('assets/image/rafiki.png'),
                  fit: BoxFit.cover,
                )),
                Text(
                  'Create your first note !',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            )
            : Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //itemCount:,
                  itemBuilder: (context, index) {
                  return Container(
                  //  child: Text(notesList[index].title ?? '', style: TextStyle(color: Colors.white, fontSize: 25),),
                  );
                },)
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40, left: 250),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(59, 59, 59, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const MakeNotes();
                    },));
                  },
                  icon: const Icon(Icons.add, size: 50),
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
