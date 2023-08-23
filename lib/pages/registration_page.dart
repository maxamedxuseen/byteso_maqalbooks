import 'dart:convert';
import 'package:byteso_maqalbooks/home.dart';
import 'package:byteso_maqalbooks/pages/login_page.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:byteso_maqalbooks/cores/getways.dart';
import 'package:byteso_maqalbooks/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:trying/widgets/header_widget.dart';

import 'common/theme_helper.dart';
// import 'package:flutter_login_ui/common/theme_helper.dart';
// import 'package:flutter_login_ui/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';

// import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool checkedValue = false;
  bool checkboxValue = false;
  String txtTitle = "";
  String txtDescription = "";
  var PHONE = "";
  var useruuid;
  var sign = Gateways().customersURL.toString();
  var NAME;
  var email;
  var phone;
  var username;
  var uuid;
  var PASSWORD;
  var status;

  Future<bool> _addnewCust() async {
    uuidgen();

    var NAME = _name.text;
    var email = _email.text;
    var phone = _phone.text;
    var username = _username.text;
    var uuid = useruuid;
    var PASSWORD = _password.text;
    var status = "Active";

    var body = {
      "name": NAME,
      "Email": email,
      "phone": phone,
      "username": username,
      "uuid": uuid.toString(),
      "password": PASSWORD,
      "status": status,
    };
    print(body);
    var response = await post(Uri.parse(sign), body: body);
    final mmm = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setBool("isLoggedIn", true);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => MainHomePage(mmm, NAME, email, PHONE,
      //             username, PASSWORD, useruuid.toString()))));
      // print("yes");
      txtTitle = "Registeration Successful";
      txtDescription = "Registeration Successful";
      _showMyDialogSuc(txtTitle, txtDescription);

      return true;
    } else {
      print("no");
      txtTitle = "Registeration invalid";
      txtDescription = "Make Sure your information is uniqe";
      _showMyDialog(txtTitle, txtDescription);
      return false;
    }
  }

  Future<void> _showMyDialogSuc(String titel, String description) async {
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(String titel, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("${txtTitle}"),
          title: Center(
              child: Icon(
            Icons.cancel_outlined,
            size: 50,
            color: Colors.red,
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var _data = [];

  void gatdate() async {
    try {
      final response = await get((Uri.parse(sign)));
      final datalist = jsonDecode(response.body) as List;

      _data = datalist;
      // setState(() {
      //   _data = datalist;
      // });
    } catch (err) {}
    // print(_data);
  }

  void uuidgen() {
    gatdate();
    // var thisData = customer[""]
    // print(_data);
    var last = _data[_data.length - 1];
    var lastUuid = last["uuid"];
    useruuid = (lastUuid + 1);
    print(useruuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight,
                  true,
                  Icons
                      .headphones_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 190, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // GestureDetector(
                          //   child: Stack(
                          //     children: [
                          //       Container(
                          //         padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(100),
                          //           border:
                          //               Border.all(width: 5, color: Colors.white),
                          //           color: Colors.white,
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.black12,
                          //               blurRadius: 20,
                          //               offset: const Offset(5, 5),
                          //             ),
                          //           ],
                          //         ),
                          //         child: Icon(
                          //           Icons.person,
                          //           color: Colors.grey.shade300,
                          //           size: 80.0,
                          //         ),
                          //       ),
                          //       Container(
                          //         padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                          //         child: Icon(
                          //           Icons.add_circle,
                          //           color: Colors.grey.shade700,
                          //           size: 25.0,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _name,
                              keyboardType: TextInputType.name,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Full Name', 'Enter your full name'),
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _email,
                              decoration: ThemeHelper().textInputDecoration(
                                  "E-mail address", "Enter your email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (!(val!.isEmpty) &&
                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: _phone,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Mobile Number", "Enter your mobile number"),
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                // if (!(val!.isEmpty) &&
                                //     !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                //   return "Enter a valid phone number";
                                // }
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                if (val.trim().length <= 10) {
                                  return 'Phone number should be 10 digits';
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: _username,
                              decoration: ThemeHelper().textInputDecoration(
                                  'username', 'Enter your username'),
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: _password,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Password", "Enter your password"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value!;
                                              state.didChange(value);
                                            });
                                          }),
                                      Text(
                                        "I accept all terms and conditions.",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) {
                              if (!checkboxValue) {
                                return 'You need to accept terms and conditions';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Register".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  final bool? isValid =
                                      _formKey.currentState?.validate();
                                  if (_name.text != "" &&
                                      _email.text != " " &&
                                      _username.text != " " &&
                                      isValid == true) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool("isLoggedIn", true);
                                    _addnewCust();
                                    // gatdate();
                                    // uuidgen();
                                  } else {}
                                }
                                // nest();

                                // print();
                                // },
                                // onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   Navigator.of(context).pushAndRemoveUntil(
                                //       MaterialPageRoute(
                                //           builder: (context) => ProfilePage()),
                                //       (Route<dynamic> route) => false);
                                // }
                                // },
                                ),
                          ),
                          SizedBox(height: 30.0),
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
    );
  }
}
