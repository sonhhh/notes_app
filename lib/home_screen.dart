import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, right: 15, left: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(37, 37, 37, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Notes',
                  style: TextStyle(color: Colors.white, fontSize: 43),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 59, 59, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 59, 59, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromRGBO(39, 39, 39, 1),
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
                                child: Center(child: const Text('Made by', style: TextStyle(
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
                    icon: Icon(
                      Icons.info_outline,
                      size: 25,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
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
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40, left: 250),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(59, 59, 59, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add, size: 50),
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
