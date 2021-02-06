import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatelessWidget {
  static String id = "registrationScreen";
  @override
  Widget build(BuildContext context) {
    return registrationScreen();
  }
}

// ignore: camel_case_types
class registrationScreen extends StatefulWidget {
  @override
  _registrationScreenState createState() => _registrationScreenState();
}

// ignore: camel_case_types
class _registrationScreenState extends State<registrationScreen> {
  final _auth = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  String tempName;
  String tempWeight;
  String tempHeight;
  String tempBmi;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.hasError) {
        return MaterialApp(home: Text("${snapshot.error}"));
      }
      if (snapshot.connectionState == ConnectionState.done) {
        return Flexible(
          child: Scaffold(
            body: SafeArea(
              child: backgroundCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "USER DETAILS ",
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
                        Texts: "ENTER YOUR NAME",
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 8, right: 8),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: KBackGroundColor,
                            fontFamily: "WorkSans",
                          ),
                          onChanged: (value) {
                            tempName = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Username',
                            hintStyle: TextStyle(
                              color: KwidgetColor,
                              fontFamily: "WorkSans",
                            ),
                          ),
                        ),
                      ),
                      // TextField(),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                descWidget(Texts: "ENTER YOUR HEIGHT"),
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: KBackGroundColor,
                                    fontFamily: "WorkSans",
                                  ),
                                  onChanged: (value) {
                                    tempHeight = value;
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Height in cm',
                                      hintStyle: TextStyle(
                                        color: KwidgetColor,
                                        fontFamily: "WorkSans",
                                      )),
                                ),
                              ],
                            ),
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
                                    if (tempName != null &&
                                        tempWeight != null &&
                                        tempHeight != null) {
                                      // isUserRegister = true;
                                      // userName = tempName;
                                      // weight = tempWeight;
                                      // height = tempHeight;
                                      tempBmi = getBMI(double.parse(tempHeight),
                                          double.parse(tempWeight));

                                      firestoreInstance
                                          .collection("users")
                                          .doc(_auth.uid)
                                          .set({
                                        "Name": tempName,
                                        "Weight": tempWeight,
                                        "Height": tempHeight,
                                        "BMI": tempBmi,
                                        getCurrentDate(): {
                                          "yourIntake": 0,
                                          "youBurned": 0
                                        }
                                      }, SetOptions(merge: true));
                                      Navigator.pushNamed(
                                          context, MainHomePage.id);
                                    }
                                  });
                                },
                                minWidth: 200.0,
                                height: 42.0,
                                child: Text(
                                  "SUBMIT",
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
            ),
          ),
        );
      }
      return MaterialApp(
        home: Center(child: Text("loading")),
      );
    });
  }
}
