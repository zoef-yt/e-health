import 'package:e_health/Screens/RegistrationScreen.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_health/methods/methods.dart';

class loginScreen extends StatefulWidget {
  static String id = "loginScreen";

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: backgroundCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: TyperAnimatedTextKit(
                        text: [
                          "E-Health",
                        ],
                        speed: (Duration(milliseconds: 250)),
                        textStyle: TextStyle(
                            color: KwidgetColor,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 50),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "LOGIN SCREEN",
                        style: TextStyle(
                            color: KwidgetColor,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
                descWidget(
                  Texts: "ENTER YOUR EMAIL",
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KBackGroundColor,
                      fontFamily: "WorkSans",
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: KwidgetColor,
                          fontFamily: "WorkSans",
                        )),
                  ),
                ),
                descWidget(
                  Texts: "ENTER YOUR Password",
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KBackGroundColor,
                      fontFamily: "WorkSans",
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(
                          color: KwidgetColor,
                          fontFamily: "WorkSans",
                        )),
                  ),
                ),
                Spacer(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 56, left: 50, right: 50, bottom: 10),
                    child: Material(
                        elevation: 5.0,
                        color: KBackGroundColor,
                        borderRadius: BorderRadius.circular(30.0),
                        child: InkWell(
                          onTap: () async {
                            if (email != null && password != null) {
                              try {
                                setState(() {
                                  showSpinner = true;
                                });
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pushNamed(context, MainHomePage.id);
                                }
                              } catch (e) {
                                showMyDialog(context, e);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } else {
                              showMyDialog(context,
                                  "Email and password cannot be empty");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
