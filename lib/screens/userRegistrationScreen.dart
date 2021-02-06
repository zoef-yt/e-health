import 'package:e_health/screens/RegistrationScreen.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userRegistrationScreen extends StatefulWidget {
  static String id = "userRegistrationScreen";

  @override
  _userRegistrationScreenState createState() => _userRegistrationScreenState();
}

class _userRegistrationScreenState extends State<userRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
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
                        "REGISTRATION SCREEN",
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
                    padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
                    child: InkWell(
                      onTap: () async {
                        if (email != null && password != null) {
                          try {
                            setState(() {
                              showSpinner = true;
                            });
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            }
                          } catch (e) {
                            print(e);
                            showMyDialog(context, e);
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else {
                          showMyDialog(
                              context, "Email and password cannot be empty");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: widgetBoxDec,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 50,
                                color: KContainerColour,
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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
