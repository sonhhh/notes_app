import 'package:app_note/sqlline/database_notes.dart';
import 'package:flutter/material.dart';

class DetailNote extends StatefulWidget {

  final int noteId;

  const DetailNote({super.key, required this.noteId});

  @override
  State<DetailNote> createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  late TextEditingController _controller;
  late TextEditingController _contentController;
  NotesProvider notesProvider = NotesProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _contentController = TextEditingController();
    initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _contentController.dispose();
  }

  Future<void> initData() async {
    List<Notes> loading = await NotesProvider().getDetail(widget.noteId);
      _controller.text = loading[0].title ?? '';
      _contentController.text = loading[0].content ?? '';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(39, 39, 39, 1),
                              icon: Center(
                                  child: Image.asset('assets/image/warning.png',
                                      fit: BoxFit.cover)),
                              title: const Text(
                                'Save changes ?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Discard',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Notes notes = Notes(
                                            id: widget.noteId,
                                            content: _contentController.text,
                                            title: _controller.text,
                                            fixDate: DateTime.now(),
                                          );
                                          notesProvider.update(notes).then((value) {
                                            final updateTitle = notes.title;
                                            Navigator.pop(context,
                                                updateTitle);
                                          }
                                          );
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.mode,
                        size: 25,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _controller,
                autofocus: true,
                maxLines: null,
                style: const TextStyle(color: Colors.white, fontSize: 48),
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 48,
                    )),
              ),
              TextField(
                controller: _contentController,
                autofocus: true,
                maxLines: null,
                style: const TextStyle(color: Colors.white, fontSize: 23),
                onChanged: (value) {
                  setState(() {
                    // content =value;
                  });
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 23,
                    )),
              )
            ],
          )),
    );
  }
}
