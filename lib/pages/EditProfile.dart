import 'dart:ffi';

import 'package:byteso_maqalbooks/cores/getways.dart';
import 'package:byteso_maqalbooks/pages/common/theme_helper.dart';
import 'package:byteso_maqalbooks/pages/login_page.dart';
import 'package:byteso_maqalbooks/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditeProfilePage extends StatefulWidget {
  int id;
  String name;
  String email;
  String phone;
  String username;
  String password;

  EditeProfilePage(
      this.id, this.name, this.email, this.phone, this.username, this.password);
  @override
  State<StatefulWidget> createState() {
    return _EditeProfilePageState();
  }
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController phone = TextEditingController();
  String txtTitle = "";
  String txtDescription = "";
  var sign = Gateways().customersURL.toString();
  Future<void> _showMyDialog(String titel, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("${txtTitle}"),
          title: Center(
              child: Icon(
            Icons.verified,
            size: 50,
            color: Colors.green,
          )),
          // iconColor: Colors.green,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text(
                  "${txtDescription}.",
                  style: TextStyle(fontSize: 15),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _updateidea() async {
    var nme = name.text;
    var phn = phone.text.trim();
    var user = username.text;
    var emil = email.text;
    var pss = Password.text;
    var body = {
      "name": nme,
      "Email": emil,
      "phone": phn,
      "username": user,
      "password": pss,
    };
    var thisID = widget.id;
    var response = await put(Uri.parse(sign + thisID.toString()), body: body);

    if (response.statusCode == 200) {
      txtTitle = "Updated Successfuly";
      txtDescription = "Updated Successfuly";
      _showMyDialog(txtTitle, txtDescription);
      print("yes");
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edite Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.phone,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4),
                                            leading: Icon(Icons.person),
                                            title: Text("Full Name"),
                                            subtitle: TextFormField(
                                              controller: name,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              decoration: const InputDecoration(
                                                // prefixIcon: Icon(
                                                //   Icons.person,
                                                //   color: Color(0xFFB6C7D1),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 217, 221, 163)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.(35.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFA7BCC7)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(35.0)),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText:
                                                    "Update Your Full Name",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0XFFA7BCC7)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4),
                                            leading: Icon(
                                                Icons.supervised_user_circle),
                                            title: Text("Username"),
                                            subtitle: TextFormField(
                                              controller: username,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              decoration: const InputDecoration(
                                                // prefixIcon: Icon(
                                                //   Icons.person,
                                                //   color: Color(0xFFB6C7D1),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 217, 221, 163)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.(35.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFA7BCC7)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(35.0)),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText:
                                                    "Update Your Username",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0XFFA7BCC7)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("Email"),
                                            subtitle: TextFormField(
                                              controller: email,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (val) {
                                                if (!(val!.isEmpty) &&
                                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                        .hasMatch(val)) {
                                                  return "Enter a valid email address";
                                                }
                                                // return null;
                                              },
                                              decoration: const InputDecoration(
                                                // prefixIcon: Icon(
                                                //   Icons.person,
                                                //   color: Color(0xFFB6C7D1),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 217, 221, 163)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.(35.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFA7BCC7)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(35.0)),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText:
                                                    "Update Your Email Address",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0XFFA7BCC7)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("Phone"),
                                            subtitle: TextFormField(
                                              controller: phone,
                                              obscureText: false,
                                              keyboardType: TextInputType.phone,
                                              validator: (val) {
                                                // if (!(val!.isEmpty) &&
                                                //     !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                                //   return "Enter a valid phone number";
                                                // }
                                                if (val == null ||
                                                    val.trim().isEmpty) {
                                                  return 'Please enter a phone number';
                                                }
                                                if (val.trim().length <= 10) {
                                                  return 'Phone number should be 10 digits';
                                                }
                                                // return null;
                                              },
                                              decoration: const InputDecoration(
                                                // prefixIcon: Icon(
                                                //   Icons.person,
                                                //   color: Color(0xFFB6C7D1),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 217, 221, 163)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.(35.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFA7BCC7)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(35.0)),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText:
                                                    "Update Your Phone Number",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0XFFA7BCC7)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.lock),
                                            title: Text("Your Password"),
                                            subtitle: TextFormField(
                                              controller: Password,
                                              obscureText: true,
                                              // keyboardType:
                                              //     TextInputType.visiblePassword,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Please enter your password";
                                                }
                                                // return null;
                                              },
                                              decoration: const InputDecoration(
                                                // prefixIcon: Icon(
                                                //   Icons.person,
                                                //   color: Color(0xFFB6C7D1),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 217, 221, 163)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.(35.0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0XFFA7BCC7)),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(35.0)),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText:
                                                    "Update Your Password",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0XFFA7BCC7)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Update'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              final bool? isValid =
                                  _formKey.currentState?.validate();
                              // print(isValid);
                              if (name.text != "" &&
                                  email.text != " " &&
                                  username.text != " " &&
                                  isValid == true) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool("isLoggedIn", true);

                                _updateidea();
                              } else {
                                // txtTitle = "Your input is invalid";
                                // txtDescription =
                                //     "Please try again Thank You!";
                                // _showMyDialog(txtTitle, txtDescription);
                              }
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) =>
                              //             MainHomePage())));
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
