import 'dart:convert';

import 'package:byteso_maqalbooks/screens/book.dart';
import 'package:byteso_maqalbooks/screens/favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart';

import '../cores/books.dart';
import '../cores/getways.dart';
import 'home.dart';

class booksPage extends StatefulWidget {
  const booksPage({super.key});

  @override
  State<booksPage> createState() => _booksPageState();
}

var bookurl = Gateways().booksURL.toString();
var catagoryUrl = Gateways().catagoryURL.toString();

var _mainData = [];

Future<List> _getData() async {
  _mainData = [];
  var date = await get((Uri.parse(bookurl)));
  var jasonData = jsonDecode(date.body);
  for (var u in jasonData) {
    _mainData.add(u);
  }

  return _mainData;
}

var Catagories = [];
Future<List> getCatagory() async {
  Catagories = [];
  var date = await get((Uri.parse(catagoryUrl)));
  var jasonData = jsonDecode(date.body);
  for (var u in jasonData) {
    Catagories.add(u);
  }
  return Catagories;
}

int currentPage = 2;

var _founditem = [];

class _booksPageState extends State<booksPage> {
  void _runFilter(String enterKeyWord) {
    var result = [];
    if (enterKeyWord.isEmpty) {
      result = _mainData;
    } else {
      result = _mainData
          .where((element) => element["name"]
              .toLowerCase()
              .contains(enterKeyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      _founditem = result;
    });
  }

  @override
  void initState() {
    _founditem = _mainData;
    // TODO: implement initState
    super.initState();
    currentPage = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          //   toolbarHeight: 80,
          //   centerTitle: true,
          //   title: Text(
          //     "MAQAL BOOKS",
          //     style: GoogleFonts.poppins(
          //       color: Color.fromARGB(255, 42, 42, 42),
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          //   ],
          //   flexibleSpace: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20)),
          //       gradient: LinearGradient(
          //           colors: [Color.fromRGBO(239, 206, 106, 1), Colors.amber],
          //           begin: Alignment.bottomCenter,
          //           end: Alignment.topCenter),
          //     ),
          //   ),
          // ),
          // bottomNavigationBar: BottomNavigationBar(
          //   backgroundColor: Color.fromARGB(255, 227, 229, 230),
          //   currentIndex: currentPage,
          //   onTap: (int index) {
          //     setState(() {
          //       currentPage = index;
          //       if (index == 0) {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: ((context) {
          //               return favoritePage();
          //             }),
          //           ),
          //         );
          //       } else if (index == 1) {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: ((context) {
          //               return homePage();
          //             }),
          //           ),
          //         );
          //       }
          //     });
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //       label: "Favorite",
          //       icon: Icon(
          //         Icons.favorite,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: "home",
          //       icon: Icon(Icons.home),
          //     ),
          //     BottomNavigationBarItem(
          //       label: "Books",
          //       icon: Icon(Icons.menu_book),
          //     ),
          //   ],
          // ),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Books",
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 15),
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: -180,
                      right: 0,
                      child: FutureBuilder(
                        future: getCatagory(),
                        // initialData: InitialData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {}
                          return Container(
                            height: 40,
                            child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.3),
                                itemCount: Catagories.length,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Center(
                                          child: Text(
                                        Catagories[i]["cat_name"],
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.amber),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: _getData(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return GridView.count(
                      childAspectRatio: 0.585,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        for (int i = 1; i <= 4; i++)
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, right: 15, left: 15),
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white60,
                            ),
                          ),
                      ],
                    );
                  }
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _founditem.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.760,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        key:
                        // ValueKey(snapshot.data[index]["id"]);
                        return Column(
                          children: [
                            Container(
                              // padding:EdgeInsets.only(left: 15, right: 15, top: 10),
                              // margin: EdgeInsets.symmetric(horizontal: 15),
                              margin: EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 237, 237),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return bookPage(
                                              id: _founditem[index]["id"],
                                              name: _founditem[index]["name"],
                                              desc: _founditem[index]
                                                  ["description"],
                                              cover: _founditem[index]["cover"],
                                              aqris: _founditem[index]["aqris"],
                                              tijaabi: _founditem[index]
                                                  ["tijaabi"],
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            _founditem[index]["cover"],
                                            height: 110,
                                            width: 120,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 8.0, top: 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _founditem[index]["name"],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xDF0D0221),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Pages :" +
                                                      _founditem[index]["pages"]
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xDF0D0221),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.book,
                                                      color: Colors.amber,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
