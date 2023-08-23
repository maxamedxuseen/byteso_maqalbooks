import 'package:byteso_maqalbooks/cores/getways.dart';
import 'package:byteso_maqalbooks/home.dart';
import 'package:byteso_maqalbooks/pages/common/theme_helper.dart';
import 'package:byteso_maqalbooks/pages/forget_password_page.dart';
import 'package:byteso_maqalbooks/pages/login_page.dart';
import 'package:byteso_maqalbooks/pages/registration_page.dart';
import 'package:byteso_maqalbooks/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class changePass extends StatefulWidget {
  String email;
  changePass(this.email);
  // const changePass({Key? key}) : super(key: key);

  @override
  _changePassState createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  double _headerHeight = 250;
  String txtTitle = "";
  String txtDescription = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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

  var sign = Gateways().customersURL.toString();

  // void nest() async {
  //   // var inputs =
  //   //     _username.text.toString().trim() + "/" + _password.text.toString();
  //   // print(login + inputs);
  //   final response = await get((Uri.parse(login + inputs)));
  //   final customers = jsonDecode(response.body);

  //   if (customers["status"] != 300) {
  //     print(customers["status"]);
  //     if (customers["status"] == "Active") {
  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.setBool("isLoggedIn", true);
  //       prefs.setString("uuid", customers["uuid"].toString());
  //       prefs.setString("cname", customers["name"]);
  //       prefs.setString("cID", customers["id"].toString());
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: ((context) => MainHomePage(
  //                   customers["id"],
  //                   customers["name"],
  //                   customers["Email"],
  //                   customers["phone"],
  //                   customers["username"],
  //                   customers["uuid"].toString(),
  //                   customers["password"]))));
  //     } else {
  //       txtTitle = "Not Active user";
  //       txtDescription = "Please contact Your Admin for Activation \n Thanku!";
  //       _showMyDialog(txtTitle, txtDescription);
  //     }
  //   } else {
  //     txtTitle = "In correct details";
  //     txtDescription =
  //         "Your Phone number or password is invalid please try again ";
  //     _showMyDialog(txtTitle, txtDescription);
  //   }
  // }

  Future<bool> _updatePass() async {
    // uuidgen();

    var PASSWORD = _password.text;
    // var status = "Active";

    var body = {
      // "name": NAME,
      // "Email": email,
      // "phone": phone,
      // "username": username,
      // "uuid": uuid.toString(),
      "password": PASSWORD,
      // "status": status,
    };
    print(body);
    var response =
        await put(Uri.parse(sign + "email/" + widget.email), body: body);
    final mmm = jsonDecode(response.body);
    if (mmm["status"] == 200) {
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setBool("isLoggedIn", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
      // print("yes");
      txtTitle = "Password Changed Successful";
      txtDescription = "Password Changed Successful";
      _showMyDialogSuc(txtTitle, txtDescription);

      return true;
    } else {
      print("no");
      txtTitle = "Somthing went wrong";
      txtDescription = "Somthing went wrong";
      _showMyDialog(txtTitle, txtDescription);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'New Password',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Change your password',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: false,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: _confirmPassword,
                                  obscureText: true,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please confirm your password";
                                    }
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'confirm your password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              //   alignment: Alignment.topRight,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 ForgotPasswordPage()),
                              //       );
                              //     },
                              //     child: Text(
                              //       "Forgot your password?",
                              //       style: TextStyle(
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 15.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Change'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final bool? isValid =
                                        _formKey.currentState?.validate();
                                    if (isValid == true &&
                                        _password.text ==
                                            _confirmPassword.text) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool("isLoggedIn", true);

                                      _updatePass();
                                    } else {
                                      txtTitle = "Your input is invalid";
                                      txtDescription =
                                          "Please match the passwords";
                                      _showMyDialog(txtTitle, txtDescription);
                                    }
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             MainHomePage())));
                                  },
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //   //child: Text('Don\'t have an account? Create'),
                              //   child: Text.rich(TextSpan(children: [
                              //     TextSpan(text: "Don\'t have an account? "),
                              //     TextSpan(
                              //       text: 'Create',
                              //       recognizer: TapGestureRecognizer()
                              //         ..onTap = () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       RegistrationPage()));
                              //         },
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           color: Theme.of(context).accentColor),
                              //     ),
                              //   ])),
                              // ),
                              // SizedBox(height: 50.0),

                              // Container(
                              //   // child: Positioned(
                              //   //   // top: MediaQuery.of(context).size.height - 100,
                              //   //   right: 0,
                              //   //   left: 0,
                              //   child: Column(
                              //     children: [
                              //       Text("Powered By"),
                              //       Image.asset(
                              //         "assets/imgs/Byteso.png",
                              //         width: 200,
                              //         height: 55,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // )
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
