import 'package:e_health/methods/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/RegistrationScreen.dart';
import 'package:e_health/screens/BMIScreen.dart';
import 'package:e_health/screens/YourWeightScreen.dart';
import 'package:e_health/screens/DietPlanScreen.dart';
import 'package:e_health/screens/ExercisePlanScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'timelineScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'settingPage.dart';

Color bmiColor;
String height;

class MainHomePage extends StatefulWidget {
  static String id = "MainHomePage";
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  String userName = "New User";
  String weight;
  String bmi;
  final _auth = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  var path;
  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserInfo() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    if (!await info.data()['date'].containsKey(getCurrentDate())) {
      print(await info.data()['date'].keys);
      print("(${getCurrentDate()})");
      firestoreInstance.collection("users").doc(_auth.uid).set(
        {
          'date': {
            getCurrentDate(): {
              "data": {
                "BMI": await info.data()['BMI'],
                "Weight": await info.data()['Weight'],
                "yourIntake": 0,
                "youBurned": 0,
              },
            },
          }
        },
        SetOptions(merge: true),
      );
    }
    userName = await info.data()['Name'];
    weight = await info.data()['Weight'];
    height = await info.data()['Height'];
    bmi = await info.data()['BMI'];
  }

  onGoBack() {
    setState(() {
      getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(home: Center(child: Text("${snapshot.error}")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: KBackGroundColor,
                animationDuration: Duration(milliseconds: 400),
                animationCurve: Curves.fastOutSlowIn,
                index: 1,
                height: 60,
                onTap: (index) {
                  if (index == 0) {
                    Future.delayed(Duration(milliseconds: 250), () {
                      Navigator.pushReplacementNamed(context, settingPage.id)
                          .then((value) => onGoBack());
                    });
                  }
                  if (index == 1) {}
                  if (index == 2) {
                    Future.delayed(Duration(milliseconds: 250), () {
                      Navigator.of(context)
                          .pushReplacementNamed(timeLineScreen.id)
                          .then((value) => onGoBack());
                    });
                  }
                },
                items: <Widget>[
                  Icon(Icons.face_rounded, size: 30, color: KwidgetColor),
                  Icon(Icons.home_rounded, size: 30, color: KwidgetColor),
                  Icon(Icons.calendar_today, size: 30, color: KwidgetColor),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    decoration: ContainerboxDecoration,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8, top: 80, right: 8, bottom: 5),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Hello, $userName",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: KwidgetColor,
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Center(
                              child: Text(
                                getCurrentDate(),
                                style: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.bold,
                                  color: KwidgetColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: WidgetPlacer(
                              // FirstTxt: bmi != null ? bmi : "Register",
                              FirstTxt: bmi,
                              SecondTxt: bmi != null
                                  ? getBmiMessage(double.parse(height),
                                      double.parse(weight))
                                  : "YOUR BMI",
                              colors: bmiColor,
                              function: () {
                                Navigator.pushNamed(
                                        context,
                                        bmi != null
                                            ? BMIScreen.id
                                            : RegistrationScreen.id)
                                    .then((value) => onGoBack());
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: WidgetPlacer(
                                    FirstTxt:
                                        // isUserRegister ? "$weight kg" : "Register",
                                        "$weight kg",
                                    SecondTxt: "Your Weight",
                                    function: () {
                                      Navigator.pushNamed(
                                              context,
                                              weight != null
                                                  ? YourWeightScreen.id
                                                  : RegistrationScreen.id)
                                          .then((value) => onGoBack());
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                // Expanded(
                                //   child: WidgetPlacer(
                                //     FirstTxt: "Trendz",
                                //     SecondTxt: "Your Info",
                                //     function: () {
                                //       Navigator.pushNamed(
                                //               context, timeLineScreen.id)
                                //           .then((value) => onGoBack());
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: WidgetPlacer(
                                  FirstTxt: bmi != null ? "🍏" : "🍏 Register",
                                  SecondTxt: bmi != null
                                      ? "Diet Plan"
                                      : "To Get Your Diet",
                                  function: () {
                                    // //todo:remember to uncomment
                                    // Navigator.pushNamed(
                                    //         context,
                                    //         isUserRegister
                                    //             ? DietPlan.id
                                    //             : RegistrationScreen.id)
                                    //     .then((value) => onGoBack());
                                    Navigator.pushNamed(context, DietPlan.id)
                                        .then((value) => onGoBack());
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: WidgetPlacer(
                                  FirstTxt:
                                      bmi != null ? "🏋️" : "🏋️ Register",
                                  SecondTxt: bmi != null
                                      ? "Exercise Plan"
                                      : "For Exercise Plan",
                                  function: () {
                                    //TODO: uncomment
                                    // Navigator.pushNamed(
                                    //         context,
                                    //         isUserRegister
                                    //             ? ExercisePage.id
                                    //             : RegistrationScreen.id)
                                    //     .then((value) => onGoBack());
                                    Navigator.pushNamed(
                                            context, ExercisePage.id)
                                        .then((value) => onGoBack());
                                  },
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
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
        });
  }
}

getCurrentDate() {
  String finalDate;
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
  finalDate = formattedDate.toString();
  return finalDate;
}
