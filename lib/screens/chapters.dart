import 'dart:convert';

import 'package:byteso_maqalbooks/cores/colors.dart';
import 'package:byteso_maqalbooks/pages/common/theme_helper.dart';
import 'package:byteso_maqalbooks/screens/listening.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../cores/getways.dart';

class chapters extends StatefulWidget {
  int id;
  String name;
  String cover;
  String csID;

  chapters(this.id, this.name, this.cover, this.csID);
  // const chapters({super.key});

  @override
  State<chapters> createState() => _chaptersState();
}

class _chaptersState extends State<chapters> {
  var chaptersUrl = Gateways().chaptersURL.toString();
  var cusURL = Gateways().customersURL.toString();

  String? customerName = "";
  String? uuid = "";
  String cusID = "";

  var _mainData = [];
  Future<List> _getData() async {
    _mainData = [];
    var cheu = chaptersUrl + "byboook/" + "${widget.id}";
    var date = await get((Uri.parse(cheu)));
    var jasonData = jsonDecode(date.body);
    for (var u in jasonData) {
      _mainData.add(u);
    }
    // print(cheu);

    return _mainData;
  }

  bool paymentcheck = false;

  void subscribed() async {
    var che = cusURL + "subs/";
    print(che + widget.csID);
    var date = await get((Uri.parse(che + widget.csID)));
    var jasonData = jsonDecode(date.body);
    // paymentcheck = jasonData;
    // print(che + widget.csID);
    if (jasonData == true) {
      setState(() {
        paymentcheck = true;
      });
    }
    print('subs : ${jasonData}');
  }

  launchWhatsApp() async {
    var names = "";

    final link = WhatsAppUnilink(
      phoneNumber: '+252612893855',
      text:
          "Hey! I am ${customerName}\nI would like to subscribe\nmy unique number is _*${uuid}*_",
    );
    await launch('$link');
  }

  Future<void> info() async {
    final prefs = await SharedPreferences.getInstance();

    String? uuidd = prefs.getString("uuid");
    String? customerN = prefs.getString("cname");
    String custID = prefs.getString("cID")!;

    customerName = customerN;
    uuid = uuidd;
    cusID = custID;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    info();
    subscribed();
    _mainData = [];
  }

  // @override
  // void setState(VoidCallback fn) async {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   final prefs = await SharedPreferences.getInstance();

  //   uuid = prefs.getString("uuid")!;
  //   customerName = prefs.getString("cname")!;
  //   cusID = prefs.getString("cID")!;

  //   subscribed();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: Center(child: Text(widget.name)),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // print();
          if (paymentcheck == false) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.attach_money,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Text(
                      "Please Subscribe in order access the chapters.",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'Subscribe'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        launchWhatsApp();
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _mainData.length,
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   childAspectRatio: 0.760,
            // ),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listeningPage(
                              _mainData[index]["chepter_name"],
                              _mainData[index]["maqal"],
                              _mainData[index]["name"],
                              _mainData[index]["cover"]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFBFB),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(_mainData[index]["cover"]),
                        title: Text(_mainData[index]["chepter_name"]),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
