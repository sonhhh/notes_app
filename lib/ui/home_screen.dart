import 'package:app_note/sqlline/database_notes.dart';
import 'package:app_note/ui/detail_note.dart';
import 'package:app_note/ui/make_notes.dart';
import 'package:app_note/ui/searching_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String? updateTitle;

  const HomeScreen({super.key, this.updateTitle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // NotesProvider notesProvider = NotesProvider();
  Notes notes = Notes();
//  bool hasNote = false;

 int? index;

  @override
  void initState() {
    super.initState();
    initData();
    deleteOn(notes);
  }

  Future<void> initData() async {
    // List<Notes> loadedNotes = await notesProvider.getNotes();
    // setState(() {
    //   noteList = loadedNotes;
    //   hasNote = noteList!.isNotEmpty;
    // });
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await notesProvider.getNotes();
  }

  Future<void> deleteOn(Notes notes) async {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await notesProvider.delete(notes);
    initData();
  }

  final _colors = [
    const Color.fromRGBO(253, 153, 255, 1),
    const Color.fromRGBO(255, 158, 158, 1),
    const Color.fromRGBO(145, 244, 143, 1),
    const Color.fromRGBO(255, 245, 153, 1),
    const Color.fromRGBO(158, 255, 255, 1),
    const Color.fromRGBO(182, 156, 255, 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 30),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(59, 59, 59, 1),
            borderRadius: BorderRadius.circular(30)),
        child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const MakeNotes();
                },
              ));
            },
            icon: const Icon(Icons.add, size: 50),
            color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(37, 37, 37, 1),
        ),
        child: SingleChildScrollView(
          child: Consumer<NotesProvider>(
            builder: (context, value, child) {
             return Column(
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
                           Navigator.push(context, MaterialPageRoute(
                             builder: (context) {
                               return SearchingNote(
                                 searchKey: '',
                               );
                             },
                           ));
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
                                 backgroundColor:
                                 const Color.fromRGBO(39, 39, 39, 1),
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
                                     child: const Center(
                                         child: Text(
                                           'Made by',
                                           style: TextStyle(color: Colors.white),
                                         )),
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
                 value.hasNotes
                     ? Column(
                   children: [
                     ListView.builder(
                       scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: value.noteList?.length,
                       itemBuilder: (context, index) {
                         return Slidable(
                           endActionPane: ActionPane(
                               motion: const ScrollMotion(),
                               extentRatio: 1,
                               children: [
                                 SlidableAction(
                                   onPressed: (context) {
                                     // setState(() {
                                     //   deleteOn(value.noteList![index]);
                                     // });
                                     deleteOn(value.noteList![index]);
                                   },
                                   borderRadius: BorderRadius.circular(10),
                                   foregroundColor: Colors.white,
                                   backgroundColor: Colors.red,
                                   icon: Icons.delete,
                                 )
                               ]),
                           child: Card(
                             color: _colors[index % _colors.length],
                             child: Container(
                               width: double.infinity,
                               margin: const EdgeInsets.all(10),
                               padding: const EdgeInsets.all(30),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: GestureDetector(
                                 onTap: () async {
                                   int selectedId = value.noteList?[index].id ?? 0;
                                   print(selectedId);
                                   Navigator.push(context, MaterialPageRoute(
                                     builder: (context) {
                                       return DetailNote(noteId: selectedId);
                                     },
                                   )).then((value) {
                                     if (value != null) {
                                       value.noteList?[index].title =
                                           value.toString();
                                     }
                                   });
                                 },
                                 child: Text(
                                   //widget.updateTitle ??
                                   value.noteList?[index].title ?? '',
                                   style: const TextStyle(
                                       color: Colors.white, fontSize: 25),
                                 ),
                               ),
                             ),
                           ),
                         );
                       },
                     )
                   ],
                 )
                     : Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                         margin: const EdgeInsets.only(top: 80),
                         child: const Image(
                           image: AssetImage('assets/image/rafiki.png'),
                           fit: BoxFit.cover,
                         )),
                     const Text(
                       'Create your first note !',
                       style: TextStyle(color: Colors.white, fontSize: 20),
                     )
                   ],
                 ),
               ],
             );
            },
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         const Text(
            //           'Notes',
            //           style: TextStyle(color: Colors.white, fontSize: 43),
            //         ),
            //         const Spacer(),
            //         Container(
            //           margin: const EdgeInsets.only(right: 15),
            //           decoration: BoxDecoration(
            //               color: const Color.fromRGBO(59, 59, 59, 1),
            //               borderRadius: BorderRadius.circular(15)),
            //           child: IconButton(
            //             onPressed: () {
            //               Navigator.push(context, MaterialPageRoute(
            //                 builder: (context) {
            //                   return SearchingNote(
            //                     searchKey: '',
            //                   );
            //                 },
            //               ));
            //             },
            //             icon: const Icon(
            //               Icons.search,
            //               size: 25,
            //             ),
            //             color: Colors.white,
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //               color: const Color.fromRGBO(59, 59, 59, 1),
            //               borderRadius: BorderRadius.circular(15)),
            //           child: IconButton(
            //             onPressed: () {
            //               showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return AlertDialog(
            //                     backgroundColor:
            //                         const Color.fromRGBO(39, 39, 39, 1),
            //                     content: const SingleChildScrollView(
            //                       child: ListBody(
            //                         children: <Widget>[
            //                           Text(
            //                             'Designed by -',
            //                             style: TextStyle(color: Colors.white),
            //                           ),
            //                           Text(
            //                             'Redesigned by -',
            //                             style: TextStyle(color: Colors.white),
            //                           ),
            //                           Text(
            //                             'Illustrations -',
            //                             style: TextStyle(color: Colors.white),
            //                           ),
            //                           Text(
            //                             'Icons -',
            //                             style: TextStyle(color: Colors.white),
            //                           ),
            //                           Text(
            //                             'Font -',
            //                             style: TextStyle(color: Colors.white),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                     actions: <Widget>[
            //                       TextButton(
            //                         child: const Center(
            //                             child: Text(
            //                           'Made by',
            //                           style: TextStyle(color: Colors.white),
            //                         )),
            //                         onPressed: () {
            //                           Navigator.of(context).pop();
            //                         },
            //                       ),
            //                     ],
            //                   );
            //                 },
            //               );
            //             },
            //             icon: const Icon(
            //               Icons.info_outline,
            //               size: 25,
            //             ),
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //     hasNote
            //         ? Column(
            //             children: [
            //               ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 shrinkWrap: true,
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 itemCount: value.noteList?.length,
            //                 itemBuilder: (context, index) {
            //                   return Slidable(
            //                     endActionPane: ActionPane(
            //                         motion: const ScrollMotion(),
            //                         extentRatio: 1,
            //                         children: [
            //                           SlidableAction(
            //                             onPressed: (context) {
            //                               setState(() {
            //                                 deleteOn(value.noteList![index]);
            //                               });
            //                             },
            //                             borderRadius: BorderRadius.circular(10),
            //                             foregroundColor: Colors.white,
            //                             backgroundColor: Colors.red,
            //                             icon: Icons.delete,
            //                           )
            //                         ]),
            //                     child: Card(
            //                       color: _colors[index % _colors.length],
            //                       child: Container(
            //                         width: double.infinity,
            //                         margin: const EdgeInsets.all(10),
            //                         padding: const EdgeInsets.all(30),
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: GestureDetector(
            //                           onTap: () async {
            //                             int selectedId = value.noteList?[index].id ?? 0;
            //                             print(selectedId);
            //                             Navigator.push(context, MaterialPageRoute(
            //                               builder: (context) {
            //                                 return DetailNote(noteId: selectedId);
            //                               },
            //                             )).then((value) {
            //                               if (value != null) {
            //                                 value.noteList?[index].title =
            //                                     value.toString();
            //                               }
            //                             });
            //                           },
            //                           child: Text(
            //                             //widget.updateTitle ??
            //                             value.noteList?[index].title ?? '',
            //                             style: const TextStyle(
            //                                 color: Colors.white, fontSize: 25),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               )
            //             ],
            //           )
            //         : Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                   margin: const EdgeInsets.only(top: 80),
            //                   child: const Image(
            //                     image: AssetImage('assets/image/rafiki.png'),
            //                     fit: BoxFit.cover,
            //                   )),
            //               const Text(
            //                 'Create your first note !',
            //                 style: TextStyle(color: Colors.white, fontSize: 20),
            //               )
            //             ],
            //           ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
