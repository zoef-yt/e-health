import 'package:e_health/Screens/RegistrationScreen.dart';
import 'package:e_health/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart//widgetFile.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'userRegistrationScreen.dart';

class welcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}

class WelcomeScreen extends StatefulWidget {
  static String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: backgroundCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
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
              SizedBox(
                height: 50,
                width: 10.0,
                child: RotateAnimatedTextKit(
                  duration: (Duration(seconds: 6)),
                  text: [
                    "It is health that is the real wealth, and not pieces of gold and silver.",
                    "Healthy citizens are the greatest asset any country can have.",
                    "Keep Calm & Drink Water"
                  ],
                  repeatForever: true,
                  textStyle: TextStyle(
                      color: KBackGroundColor,
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 56, left: 50, right: 50),
                  child: Material(
                      elevation: 5.0,
                      color: KBackGroundColor,
                      borderRadius: BorderRadius.circular(30.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, loginScreen.id);
                        },
                        child: Expanded(
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
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
                child: InkWell(
                  onTap: () {
                    print("hi");
                    Navigator.pushNamed(context, userRegistrationScreen.id);
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
