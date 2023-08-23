import 'package:byteso_maqalbooks/cores/getways.dart';
import 'package:byteso_maqalbooks/home.dart';
import 'package:byteso_maqalbooks/pages/common/theme_helper.dart';
import 'package:byteso_maqalbooks/pages/forget_password_page.dart';
import 'package:byteso_maqalbooks/pages/registration_page.dart';
import 'package:byteso_maqalbooks/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  String txtTitle = "";
  String txtDescription = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Future<void> _showMyDialog(String titel, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${txtTitle}"),
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 25,
              )
            ],
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text("${txtDescription}.")),
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

  var login = Gateways().customerLoginURL.toString();

  void nest() async {
    var inputs =
        _username.text.toString().trim() + "/" + _password.text.toString();
    print(login + inputs);
    final response = await get((Uri.parse(login + inputs)));
    final customers = jsonDecode(response.body);

    if (customers["status"] != 300) {
      print(customers["status"]);
      if (customers["status"] == "Active") {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("uuid", customers["uuid"].toString());
        prefs.setString("cname", customers["name"]);
        prefs.setString("cID", customers["id"].toString());
        prefs.setString("email", customers["Email"].toString());
        prefs.setString("username", customers["username"].toString());
        prefs.setString("password", customers["password"].toString());
        prefs.setString("phone", customers["phone"].toString());

        // -------------------------------------
        int cid = int.parse(prefs.getString("cID")!);
        String? cname = prefs.getString("cname");
        String? cemail = prefs.getString("email");
        String? cphone = prefs.getString("phone");
        String? cuser = prefs.getString("username");
        String? cuuId = prefs.getString("uuid");
        String? cpass = prefs.getString("password");

        var obj = {
          "id": cid,
          "name": cname,
          "phone": cphone,
          "email": cemail,
          "uuid": cuuId,
          "user": cuser,
          "pass": cpass
        };

        print(obj);

        // ------------------------------------------------
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => MainHomePage(
                    customers["id"],
                    customers["name"],
                    customers["Email"],
                    customers["phone"],
                    customers["username"],
                    customers["uuid"].toString(),
                    customers["password"]))));
      } else {
        txtTitle = "Not Active user";
        txtDescription = "Please contact Your Admin for Activation \n Thanku!";
        _showMyDialog(txtTitle, txtDescription);
      }
    } else {
      txtTitle = "In correct details";
      txtDescription =
          "Your Phone number or password is invalid please try again ";
      _showMyDialog(txtTitle, txtDescription);
    }
  }

  // void check() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   int cid = int.parse(prefs.getString("cid")!);
  //   String cname = prefs.getString("cname")!;
  //   String cemail = prefs.getString("email")!;
  //   String cphone = prefs.getString("phone")!;
  //   String cuser = prefs.getString("username")!;
  //   String cuuId = prefs.getString("uuid")!;
  //   String cpass = prefs.getString("password")!;

  //   bool log = prefs.getBool("isLoggedIn") ?? false;
  //   if (log) {
  //     print("Not");
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: ((context) => MainHomePage(
  //                 cid, cname, cemail, cphone, cuser, cuuId, cpass))));
  //   } else {
  //     print("not logged");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // check();
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
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: _username,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your Full Number";
                                    }
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Phone',
                                      '+25261***   Enter your phone Number '),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: true,
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
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final bool? isValid =
                                        _formKey.currentState?.validate();
                                    if (isValid == true) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool("isLoggedIn", true);

                                      nest();
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
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ])),
                              ),
                              SizedBox(height: 50.0),

                              Container(
                                // child: Positioned(
                                //   // top: MediaQuery.of(context).size.height - 100,
                                //   right: 0,
                                //   left: 0,
                                child: Column(
                                  children: [
                                    Text("Powered By"),
                                    Image.asset(
                                      "assets/imgs/Byteso.png",
                                      width: 200,
                                      height: 55,
                                    ),
                                  ],
                                ),
                              ),
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
