import 'dart:convert';

import 'package:byteso_maqalbooks/pages/EditProfile.dart';
import 'package:byteso_maqalbooks/pages/login_page.dart';
import 'package:byteso_maqalbooks/pages/profile_page.dart';
import 'package:byteso_maqalbooks/screens/book.dart';
import 'package:byteso_maqalbooks/screens/books.dart';
import 'package:byteso_maqalbooks/screens/favorite.dart';
import 'package:byteso_maqalbooks/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cores/books.dart';
import '../cores/getways.dart';

class MainHomePage extends StatefulWidget {
  int id;
  String name;
  String email;
  String phone;
  String username;
  String password;
  String uuid;
  MainHomePage(this.id, this.name, this.email, this.phone, this.username,
      this.password, this.uuid);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

List Screens = [
  // favoritePage(),
  homePage(),
  booksPage(),
];
int _page = 0;
// var bookurl = Gateways().booksURL.toString();
// var catagoryUrl = Gateways().catagoryURL.toString();

// var _mainData = [];

// Future<List> _getData() async {
//   _mainData = [];
//   var date = await get((Uri.parse(bookurl)));
//   var jasonData = jsonDecode(date.body);
//   for (var u in jasonData) {
//     _mainData.add(u);
//   }

//   return _mainData;
// }

// var newData = [];
// Future<List> getlatest() async {
//   newData = [];
//   var date = await get((Uri.parse(bookurl + "leatest/")));
//   print(bookurl);
//   var jasonData = jsonDecode(date.body);
//   for (var u in jasonData) {
//     newData.add(u);
//   }

//   return newData;
// }

// var Catagories = [];
// Future<List> getCatagory() async {
//   Catagories = [];
//   var date = await get((Uri.parse(catagoryUrl)));
//   var jasonData = jsonDecode(date.body);
//   for (var u in jasonData) {
//     Catagories.add(u);
//   }
//   // print(Catagories);
//   currentPage = 1;

//   return Catagories;
// }

int currentPage = 0;
double _drawerIconSize = 24;
double _drawerFontSize = 17;

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(catagoryUrl);
    // getCatagory();
    // getlatest();
    // _getData();
    currentPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.bar_chart_rounded),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              "MAQAL BOOKS",
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 42, 42, 42),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // actions: [
            //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
            // ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Color.fromRGBO(239, 206, 106, 1), Colors.amber],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
            ),
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                    0.0,
                    1.0
                  ],
                      colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ])),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditeProfilePage(
                                            widget.id,
                                            widget.name,
                                            widget.email,
                                            widget.phone,
                                            widget.username,
                                            widget.password)));
                              },
                              icon: Icon(Icons.edit)),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                widget.email,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.verified_user_sharp,
                      size: _drawerIconSize,
                      color: Colors.black,
                      // color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      'Profile Page',
                      style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Colors.black,
                        // color: Theme.of(context).accentColor
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(widget.name,
                                widget.email, widget.phone, widget.username)),
                      );
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 1,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                      size: _drawerIconSize,
                      // color: Theme.of(context).accentColor,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: _drawerFontSize,
                        // color: Theme.of(context).accentColor
                        color: Colors.black,
                      ),
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isLoggedIn", false);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 227, 229, 230),
            currentIndex: _page,
            onTap: (int index) {
              setState(() {
                _page = index;
              });
            },
            items: const [
              // BottomNavigationBarItem(
              //   label: "Favorite",
              //   icon: Icon(
              //     Icons.favorite,
              //   ),
              // ),
              BottomNavigationBarItem(
                label: "home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Books",
                icon: Icon(Icons.menu_book),
              ),
            ],
          ),
          body: Screens[_page],
          // ListView(
          //   children: [
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Row(
          //       children: [
          //         SizedBox(
          //           width: 15,
          //         ),
          //         Text(
          //           "Recent Books",
          //           style: GoogleFonts.poppins(fontSize: 22),
          //         )
          //       ],
          //     ),
          //     SizedBox(
          //       height: 15,
          //     ),
          //     Container(
          //       height: 180,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //               top: 0,
          //               bottom: 0,
          //               left: -140,
          //               right: 0,
          //               child: Container(
          //                 height: 180,
          //                 child: FutureBuilder(
          //                   future: getlatest(),
          //                   // initialData: InitialData,
          //                   builder:
          //                       (BuildContext context, AsyncSnapshot snapshot) {
          //                     if (snapshot.data == null) {
          //                       return Center(
          //                         child: CircularProgressIndicator(),
          //                       );
          //                     }
          //                     return PageView.builder(
          //                         controller:
          //                             PageController(viewportFraction: 0.4),
          //                         itemCount: newData.length,
          //                         itemBuilder: (_, i) {
          //                           return Container(
          //                             child: InkWell(
          //                               onTap: () {
          //                                 Navigator.push(context,
          //                                     MaterialPageRoute(
          //                                         builder: (context) {
          //                                   return bookPage(
          //                                       id: snapshot.data[i]["id"],
          //                                       name: snapshot.data[i]["name"],
          //                                       desc: snapshot.data[i]
          //                                           ["description"],
          //                                       cover: snapshot.data[i]
          //                                           ["cover"],
          //                                       aqris: snapshot.data[i]
          //                                           ["aqris"],
          //                                       maqal: snapshot.data[i]
          //                                           ["maqal"]);
          //                                 }));
          //                               },
          //                             ),
          //                             height: 180,
          //                             width: MediaQuery.of(context).size.width,
          //                             margin: const EdgeInsets.only(right: 10),
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(15),
          //                               image: DecorationImage(
          //                                 image:
          //                                     NetworkImage(newData[i]["cover"]),
          //                                 // image: AssetImage("assets/imgs/1.png"),
          //                                 fit: BoxFit.cover,
          //                               ),
          //                             ),
          //                           );
          //                         });
          //                   },
          //                 ),
          //               ))
          //         ],
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(bottom: 15, top: 15),
          //       height: 40,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //             top: 0,
          //             bottom: 0,
          //             left: -180,
          //             right: 0,
          //             child: FutureBuilder(
          //               future: getCatagory(),
          //               // initialData: InitialData,
          //               builder:
          //                   (BuildContext context, AsyncSnapshot snapshot) {
          //                 if (snapshot.data == null) {}
          //                 return Container(
          //                   height: 40,
          //                   child: PageView.builder(
          //                       controller:
          //                           PageController(viewportFraction: 0.3),
          //                       itemCount: Catagories.length,
          //                       itemBuilder: (_, i) {
          //                         return InkWell(
          //                           onTap: () {
          //                             getlatest();
          //                           },
          //                           child: Container(
          //                             padding: EdgeInsets.only(left: 7),
          //                             child: Center(
          //                                 child: Text(
          //                               Catagories[i]["cat_name"],
          //                               style: TextStyle(fontSize: 18),
          //                               overflow: TextOverflow.ellipsis,
          //                             )),
          //                             height: 40,
          //                             width: MediaQuery.of(context).size.width,
          //                             margin: const EdgeInsets.only(right: 10),
          //                             decoration: BoxDecoration(
          //                                 borderRadius:
          //                                     BorderRadius.circular(7),
          //                                 color: Colors.amber),
          //                           ),
          //                         );
          //                       }),
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     FutureBuilder(
          //       future: _getData(),
          //       // initialData: InitialData,
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         if (snapshot.data == null) {}
          //         return GridView.builder(
          //             physics: NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemCount: _mainData.length,
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               childAspectRatio: 0.760,
          //             ),
          //             itemBuilder: (BuildContext context, int index) {
          //               return Column(
          //                 children: [
          //                   Container(
          //                     // padding:EdgeInsets.only(left: 15, right: 15, top: 10),
          //                     // margin: EdgeInsets.symmetric(horizontal: 15),
          //                     margin: EdgeInsets.only(right: 10, left: 10),
          //                     decoration: BoxDecoration(
          //                       color: Color.fromARGB(255, 238, 237, 237),
          //                       borderRadius: BorderRadius.circular(20),
          //                     ),
          //                     child: Column(
          //                       children: [
          //                         InkWell(
          //                           onTap: () {
          //                             Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                 builder: ((context) => bookPage(
          //                                     id: snapshot.data[index]["id"],
          //                                     name: snapshot.data[index]
          //                                         ["name"],
          //                                     desc: snapshot.data[index]
          //                                         ["description"],
          //                                     cover: snapshot.data[index]
          //                                         ["cover"],
          //                                     aqris: snapshot.data[index]
          //                                         ["aqris"],
          //                                     maqal: snapshot.data[index]
          //                                         ["maqal"])),
          //                               ),
          //                             );
          //                           },
          //                           child: Container(
          //                             margin: EdgeInsets.all(10),
          //                             child: Column(
          //                               children: [
          //                                 Image.network(
          //                                   _mainData[index]["cover"],
          //                                   height: 110,
          //                                   width: 120,
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(
          //                                       bottom: 8.0, top: 8),
          //                                   alignment: Alignment.centerLeft,
          //                                   child: Text(
          //                                     _mainData[index]["name"],
          //                                     style: TextStyle(
          //                                       fontSize: 18,
          //                                       color: Color(0xDF0D0221),
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                     overflow: TextOverflow.ellipsis,
          //                                   ),
          //                                 ),
          //                                 Padding(
          //                                   padding: EdgeInsets.symmetric(
          //                                       vertical: 10),
          //                                   child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment
          //                                             .spaceBetween,
          //                                     children: [
          //                                       Text(
          //                                         "Pages :" +
          //                                             _mainData[index]["pages"]
          //                                                 .toString(),
          //                                         style: TextStyle(
          //                                           fontSize: 15,
          //                                           fontWeight: FontWeight.bold,
          //                                           color: Color(0xDF0D0221),
          //                                         ),
          //                                       ),
          //                                       IconButton(
          //                                           onPressed: () {},
          //                                           icon: Icon(
          //                                             Icons.favorite_border,
          //                                             color: Colors.amber,
          //                                           ))
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             });
          //       },
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
