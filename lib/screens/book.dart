import 'package:byteso_maqalbooks/screens/chapters.dart';
import 'package:flutter/material.dart';
import 'package:byteso_maqalbooks/screens/tijaabi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aqriso.dart';

class bookPage extends StatefulWidget {
  // const bookPage({super.key});
  int id;
  String name;
  String desc;
  String cover;
  String aqris;
  String tijaabi;

  bookPage(
      {required this.id,
      required this.name,
      required this.desc,
      required this.cover,
      required this.aqris,
      required this.tijaabi});

  @override
  State<bookPage> createState() => _bookPageState();
}

class _bookPageState extends State<bookPage> {
  String cusID = "";
  Future<void> info() async {
    final prefs = await SharedPreferences.getInstance();

    // String? uuidd = prefs.getString("uuid");
    // String? customerN = prefs.getString("cname");
    String custID = prefs.getString("cID")!;

    // customerName = customerN;
    // uuid = uuidd;
    cusID = custID;
  }

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[200],
          centerTitle: true,
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 210,
              decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(widget.cover),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => tijaabiPage(
                                widget.tijaabi, widget.name, widget.cover),
                          ),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        child: Row(
                          children: [
                            Icon(Icons.support),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Tijaabi',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chapters(
                                widget.id, widget.name, widget.cover, cusID),
                          ),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        child: Row(
                          children: [
                            Icon(Icons.headphones),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Dhageyso',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AqrisoPage(
                                  widget.id, widget.name, widget.aqris)),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        child: Row(
                          children: [
                            Icon(Icons.menu_book),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Aqriso',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "About",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 330,
                      child: Text(widget.desc),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
