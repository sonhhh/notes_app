import 'package:app_note/sqlline/database_notes.dart';
import 'package:app_note/ui/detail_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchingNote extends StatefulWidget {
  String searchKey;

  SearchingNote({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<SearchingNote> createState() => _SearchingNoteState();
}

class _SearchingNoteState extends State<SearchingNote> {
  TextEditingController _controller = TextEditingController();
  late NotesProvider notesProvide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    notesProvide = Provider.of<NotesProvider>(context, listen: false);
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
      body: Consumer<NotesProvider>(
        builder: (BuildContext context, value, Widget? child) {
          final List<Notes>? note = value.searchRerults;
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 70, right: 15, left: 15),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(37, 37, 37, 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                    onChanged: (searchKeyword) {
                      notesProvide.getSearch(searchKeyword);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        hintText: 'Search by the keyword...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              _controller.clear();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.close,
                              color: Colors.white70, size: 20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  value.hasText
                      ?
                      note != null && note.isNotEmpty ?
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: value.searchRerults?.length ?? 0,
                          itemBuilder: (context, index) {
                            final title = note[index].title;
                            final id = note[index].id;
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListTile(
                                  title: GestureDetector(
                                      onTap: () {
                                        if (id != null) {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return DetailNote(noteId: id);
                                            },
                                          ));
                                        }
                                      },
                                      child: Text(title!,
                                          style: const TextStyle(
                                              color: Colors.white)))),
                            );
                          },
                        )
                      :
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                            child: Center(
                          child: Image.asset('assets/image/cuate.png'),
                        )),
                        const Positioned(
                            bottom: 0,
                            child: Text(
                              'File not found. Try searching again.',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ))
                      ],
                    ),
                  )
                  :
                  const SizedBox(),
                ],
              ),
            ),
          );
        },
        // child: Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.only(top: 70, right: 15, left: 15),
        //   decoration: const BoxDecoration(
        //     color: Color.fromRGBO(37, 37, 37, 1),
        //   ),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         TextField(
        //           autofocus: true,
        //           style: const TextStyle(color: Colors.white),
        //           controller: _controller,
        //           onChanged: (searchKeyword) {
        //             setState(() {
        //               widget.searchKey = searchKeyword;
        //             });
        //             search(widget.searchKey);
        //           },
        //           decoration: InputDecoration(
        //               filled: true,
        //               fillColor: Colors.white.withOpacity(0.1),
        //               hintText: 'Search by the keyword...',
        //               hintStyle: const TextStyle(color: Colors.white54),
        //               border: InputBorder.none,
        //               disabledBorder: InputBorder.none,
        //               suffixIcon: IconButton(
        //                 onPressed: () {
        //                   if (_controller.text.isNotEmpty) {
        //                     _controller.clear();
        //                   } else {
        //                     Navigator.pop(context);
        //                   }
        //                 },
        //                 icon: const Icon(Icons.close,
        //                     color: Colors.white70, size: 20),
        //               ),
        //               enabledBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(30))),
        //         ),
        //         hasText
        //             ? ListView.builder(
        //               shrinkWrap: true,
        //               scrollDirection: Axis.vertical,
        //               itemCount: searchRerults.length,
        //               itemBuilder: (context, index) {
        //                 final List<Notes> note = Notes.fromMaps(searchRerults.cast<Map<String, dynamic>>());
        //                 final title = note[index]?.title ;
        //                 final id = note[index].id ;
        //                 return Container(
        //                   height: MediaQuery.of(context).size.height,
        //                   child: ListTile(
        //                     title: GestureDetector(
        //                       onTap: () {
        //                         if(id != null){
        //                           Navigator.push(context,MaterialPageRoute(builder: (context) {
        //                             return DetailNote(noteId: id);
        //                           },) );
        //                         }
        //                       },
        //                       child: Text(title!,
        //                           style: const TextStyle(color: Colors.white)),
        //                     ),
        //                   ),
        //                 );
        //               },
        //             )
        //             : const SizedBox(
        //                 height: 120,
        //               ),
        //         Visibility(
        //             visible: !hasText,
        //             child: SizedBox(
        //               height: 300,
        //               child: Stack(
        //                 children: [
        //                   Positioned(
        //                       child: Center(
        //                     child: Image.asset('assets/image/cuate.png'),
        //                   )),
        //                   const Positioned(
        //                       bottom: 0,
        //                       child: Text(
        //                         'File not found. Try searching again.',
        //                         style: TextStyle(fontSize: 20, color: Colors.white),
        //                       ))
        //                 ],
        //               ),
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
