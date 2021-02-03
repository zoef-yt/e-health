import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/screens/homePageFile.dart';

class GoalScreen extends StatelessWidget {
  static String id = "goalScreen";
  @override
  Widget build(BuildContext context) {
    return goalScreen();
  }
}

// ignore: camel_case_types
class goalScreen extends StatefulWidget {
  @override
  _goalScreenState createState() => _goalScreenState();
}

class _goalScreenState extends State<goalScreen> {
  String tempWeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: backgroundCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "SET YOUR WEIGHT GOAL",
                  style: TextStyle(
                      color: KwidgetColor,
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  descWidget(Texts: "ENTER YOUR WEIGHT"),
                  TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KBackGroundColor,
                      fontFamily: "WorkSans",
                    ),
                    onChanged: (value) {
                      tempWeight = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Weight in kg',
                        hintStyle: TextStyle(
                          color: KwidgetColor,
                          fontFamily: "WorkSans",
                        )),
                  ),
                ],
              ),
              Spacer(),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: KBackGroundColor,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (tempWeight != null) {
                              goalWeight = tempWeight;
                              Navigator.pop(
                                context,
                              );
                            }
                          });
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          "Recalculate",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
    );
  }
}
