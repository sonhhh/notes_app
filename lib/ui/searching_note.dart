import 'package:flutter/material.dart';

class SearchingNote extends StatefulWidget {
  const SearchingNote({super.key});

  @override
  State<SearchingNote> createState() => _SearchingNoteState();
}

class _SearchingNoteState extends State<SearchingNote> {
  bool hasText = false;
  TextEditingController _controller = TextEditingController();

  void _onTextChange(String valus) {
    setState(() {
      hasText = valus.isNotEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
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
        width: double.infinity,
        padding: const EdgeInsets.only(top: 70, right: 15, left: 15),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(37, 37, 37, 1),
        ),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              controller: _controller,
              onChanged: _onTextChange,
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
            const SizedBox(height: 120),
            Visibility(
                visible: !hasText,
                child: SizedBox(
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))
                    ],
                  ),
                )

                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(image: AssetImage('assets/image/cuate.png'))
                //   ),
                //   child: Image.asset('assets/image/cuate.png'),
                // )
                ),
          ],
        ),
      ),
    );
  }
}
