import 'package:e_health/screens/settingPage.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';

class timeLineScreen extends StatelessWidget {
  static String id = "timelineScreen";
  @override
  Widget build(BuildContext context) {
    return TimeLineScreen();
  }
}

// ignore: camel_case_types
class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  List weights = [];
  List dates = [];
  final _auth = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  List map = [];
  var data = {};
  String thatDate;

  @override
  void initState() {
    map = [];
    // getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserInfo() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    final weights =
        await info.data()['date'][getCurrentDate()]['data']['Weight'];
    info.data()['date'].forEach((k, v) {
      data = {
        'dates': {
          k: {
            "BMI": v['data']['BMI'],
            "Weight": v['data']['Weight'],
            "yourIntake": v['data']['yourIntake'],
            "youBurned": v['data']['youBurned'],
          },
        }
      };
      print(k);
      map.add(data);
    });
  }
  //
  // onGoBack() {
  //   setState(() {
  //     getUserInfo();
  //   });
  // }

  String tempWeight;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(
                      color: KwidgetColor,
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: KBackGroundColor,
              animationDuration: Duration(milliseconds: 400),
              animationCurve: Curves.fastOutSlowIn,
              index: 2,
              height: 60,
              onTap: (index) {
                if (index == 0) {
                  Future.delayed(Duration(milliseconds: 250), () {
                    Navigator.pushNamed(context, settingPage.id);
                  });
                }
                if (index == 1) {
                  Navigator.of(context).pushReplacementNamed(MainHomePage.id);

                  // Future.delayed(Duration(milliseconds: 250), () {
                  //   Navigator.popUntil(
                  //       context, ModalRoute.withName(MainHomePage.id));
                  // });
                  // Navigator.pushNamed(context, MainHomePage.id);
                }
                if (index == 2) {
                  print("tapped 0");
                }
              },
              items: <Widget>[
                Icon(Icons.face_rounded, size: 30, color: KwidgetColor),
                Icon(Icons.home_rounded, size: 30, color: KwidgetColor),
                Icon(Icons.calendar_today, size: 30, color: KwidgetColor),
              ],
            ),
            body: SafeArea(
              child: backgroundCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "Timeline",
                        style: TextStyle(
                            color: KwidgetColor,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: 250,
                          decoration: BoxDecoration(color: Color(0xFFf5f4f4)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: map.length,
                            itemBuilder: (BuildContext context, int position) {
                              var maps = map[position];
                              print(maps);
                              var dates = maps['dates'].keys.toString();
                              dates = dates.substring(1, dates.length - 1);
                              print(dates);
                              thatDate = dates;

                              return timelineWidget(
                                date: thatDate,
                                // date: maps['dates'][dates].toString(),
                                BMI: maps['dates'][dates]['BMI'],
                                burned: maps['dates'][dates]['youBurned'],
                                intake: maps['dates'][dates]['yourIntake'],
                                weight: maps['dates'][dates]['Weight'],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 16.0),
                    //     child: Material(
                    //       elevation: 5.0,
                    //       color: KBackGroundColor,
                    //       borderRadius: BorderRadius.circular(30.0),
                    //       child: MaterialButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             Navigator.pop(context);
                    //           });
                    //         },
                    //         minWidth: 200.0,
                    //         height: 42.0,
                    //         child: Text(
                    //           "DONE",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: "WorkSans",
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: backgroundCard(
              child: ModalProgressHUD(
                inAsyncCall: true,
                color: KwidgetColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class timelineWidget extends StatelessWidget {
  timelineWidget({this.weight, this.date, this.BMI, this.burned, this.intake});
  final String date;
  final String weight;
  final String BMI;
  final int intake;
  final int burned;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: widgetBoxDec,
          width: 300,
          child: Column(children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Date : $date",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: KContainerColour,
                    fontFamily: "WorkSans"),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "BMI $BMI",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: KContainerColour,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.bold),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Weight $weight",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: KContainerColour,
                  fontFamily: "WorkSans",
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Your Intake $intake",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: KContainerColour,
                    fontFamily: "WorkSans"),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "You Burned $burned",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: KContainerColour,
                    fontFamily: "WorkSans"),
              ),
            ),
          ])),
    );
  }
}

// ///////
