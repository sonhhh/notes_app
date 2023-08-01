import 'package:flutter/material.dart';

class DetailNote extends StatefulWidget {
  const DetailNote({super.key});

  @override
  State<DetailNote> createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  late TextEditingController _controller;
  late TextEditingController _contentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _contentController.dispose();
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
                      onPressed: () {},
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
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 23,
                    )),
              )
            ],
          )
          // TextField(),
          // TextField(),
          ),
    );
  }
}
