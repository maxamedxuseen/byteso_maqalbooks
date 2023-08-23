import 'dart:convert';

import 'package:byteso_maqalbooks/cores/getways.dart';
import 'package:byteso_maqalbooks/pages/common/theme_helper.dart';
import 'package:byteso_maqalbooks/pages/updatepassword.dart';
import 'package:byteso_maqalbooks/screens/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
// import 'package:trying/common/theme_helper.dart';

import 'profile_page.dart';
import 'widgets/header_widget.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  // const ForgotPasswordVerificationPage({Key? key}) : super(key: key);
  String mail;
  ForgotPasswordVerificationPage(this.mail);

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController otptext = TextEditingController();
  OtpFieldController otptext = OtpFieldController();

  bool _pinSuccess = false;
  String kul = "";
  String txtTitle = "";
  String txtDescription = "";
  var cusURL = Gateways().customersURL.toString();

  void requestOTP(String Email) async {
    var che = cusURL + "forget/";
    var date = await get((Uri.parse(che + Email)));
    var jasonData = jsonDecode(date.body);
    if (jasonData["status"] == 200) {
      print("SENT");
    } else {
      print("NOT SENT");
    }
  }

  void VerifieOTP(String Email, String OTP) async {
    var che = cusURL + "otp/chack/";
    var date = await get((Uri.parse(che + Email + "/" + OTP)));
    var jasonData = jsonDecode(date.body);
    if (jasonData["status"] == 200) {
      print("Verified");
      txtTitle = "Invalid OTP";
      txtDescription = "Verification code is invalid or expired.";
      _showMyDialogSuc(txtTitle, txtDescription);
    } else {
      print("NOT Verified");
      txtTitle = "Invalid OTP";
      txtDescription = "Verification code is invalid or expired.";
      _showMyDialog(txtTitle, txtDescription);

      // xyx();
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
                    MaterialPageRoute(
                        builder: (context) => changePass(widget.mail)),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestOTP(widget.mail);
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verification',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Enter the verification code we just sent you on your email address.',
                              style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            OTPTextField(
                              controller: otptext,
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 40,
                              style: TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                setState(() {
                                  _pinSuccess = true;
                                  kul = pin.toString();
                                });
                              },
                            ),
                            SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "If you didn't receive a code! ",
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Resend',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Successful",
                                                "Verification code resend successful.",
                                                context);
                                          },
                                        );
                                        requestOTP(widget.mail);
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              decoration: _pinSuccess
                                  ? ThemeHelper().buttonBoxDecoration(context)
                                  : ThemeHelper().buttonBoxDecoration(
                                      context, "#AAAAAA", "#757575"),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Verify".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: _pinSuccess
                                    ? () {
                                        // Navigator.of(context)
                                        //     .pushAndRemoveUntil(
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 homePage()),
                                        //         (Route<dynamic> route) =>
                                        //             false);
                                        // print(kul);
                                        VerifieOTP(widget.mail, kul);
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
