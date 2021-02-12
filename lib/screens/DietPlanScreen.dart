import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/methods/mealNameWithKcal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DietPlan extends StatelessWidget {
  static String id = "dietPlan";
  @override
  Widget build(BuildContext context) {
    return dietPlan();
  }
}

class dietPlan extends StatefulWidget {
  @override
  _dietPlanState createState() => _dietPlanState();
}

//
// var breakfast = {
//   '3 Scrambled Eggs': 221,
//   "Glass of Orange Juice": 118,
//   '3 slices Wheat Toast,\n buttered': 497,
// };
String textField;

class _dietPlanState extends State<dietPlan> {
  int yourIntake = 0;
  String bmi;
  final _auth = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  void initState() {
    getUserInfo();
    getUserInfo2();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserInfo() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    // bmi = await info.data()['date'][getCurrentDate()]['data']['BMI'];
    // yourIntake =
    //     await info.data()['date'][getCurrentDate()]['data']['yourIntake'];
    // print("done");
  }

  Future<String> getUserInfo2() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    bmi = await info.data()['date'][getCurrentDate()]['data']['BMI'];
    yourIntake =
        await info.data()['date'][getCurrentDate()]['data']['yourIntake'];
    print("done");
  }

  onGoBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(home: Text("${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SafeArea(
              child: backgroundCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Hero(
                        tag: "diet",
                        child: Text(
                          "DIET PLAN 🍏",
                          style: TextStyle(
                              color: KwidgetColor,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          yourIntake >= 1
                              ? "TODAY YOU GAINED: ${yourIntake}🔥"
                              : "Start your intake",
                          style: TextStyle(
                              color: KwidgetColor,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xFFf5f4f4)),
                          child: ListView(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  mealTextWidget(whichMeal: "Breakfast"),
                                  Container(
                                    height: 190,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: breakfastLow.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        if (double.parse(bmi) <= 18.5) {
                                          return perMealWidget(
                                            mealName: breakfastLow[position],
                                            mealCal: breakfastLowKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            breakfastLowKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        breakfastLowKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    breakfastLowKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 18.5 &&
                                            double.parse(bmi) <= 25) {
                                          return perMealWidget(
                                            mealCal:
                                                breakfastNormalKcal[position],
                                            mealName: breakfastNormal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            breakfastNormalKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        breakfastNormalKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    breakfastNormalKcal[
                                                        position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 25) {
                                          return perMealWidget(
                                            mealName: breakfastHigh[position],
                                            mealCal:
                                                breakfastHighKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            breakfastHighKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        breakfastHighKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    breakfastHighKcal[position];
                                              });
                                            },
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  mealTextWidget(whichMeal: "Snack 1"),
                                  Container(
                                    height: 190,
                                    child: ListView.builder(
                                      itemCount: snack1High.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        if (double.parse(bmi) <= 18.5) {
                                          return perMealWidget(
                                            mealName: snack1Low[position],
                                            mealCal: snack1LowKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack1LowKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack1LowKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack1LowKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 18.5 &&
                                            double.parse(bmi) <= 25) {
                                          return perMealWidget(
                                            mealName: snack1Normal[position],
                                            mealCal: snack1NormalKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack1NormalKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack1NormalKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack1NormalKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 25) {
                                          return perMealWidget(
                                            mealName: snack1High[position],
                                            mealCal: snack1HighKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack1HighKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack1HighKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack1HighKcal[position];
                                              });
                                            },
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  mealTextWidget(whichMeal: "Lunch"),
                                  Container(
                                    height: 190,
                                    child: ListView.builder(
                                      itemCount: lunchHigh.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        if (double.parse(bmi) <= 18.5) {
                                          return perMealWidget(
                                            mealName: lunchLow[position],
                                            mealCal: lunchLowKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            lunchLowKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        lunchLowKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    lunchLowKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 18.5 &&
                                            double.parse(bmi) <= 25) {
                                          return perMealWidget(
                                            mealName: lunchNormal[position],
                                            mealCal: lunchNormalKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            lunchNormalKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        lunchNormalKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    lunchNormalKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 25) {
                                          return perMealWidget(
                                            mealName: lunchHigh[position],
                                            mealCal: lunchHighKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            lunchHighKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        lunchHighKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    lunchHighKcal[position];
                                              });
                                            },
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  mealTextWidget(whichMeal: "Snack 2"),
                                  Container(
                                    height: 190,
                                    child: ListView.builder(
                                      itemCount: snack2High.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        if (double.parse(bmi) <= 18.5) {
                                          return perMealWidget(
                                            mealName: snack2Low[position],
                                            mealCal: snack2LowKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack2LowKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack2LowKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack2LowKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 18.5 &&
                                            double.parse(bmi) <= 25) {
                                          return perMealWidget(
                                            mealName: snack2Normal[position],
                                            mealCal: snack2NormalKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack2NormalKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack2NormalKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack2NormalKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 25) {
                                          return perMealWidget(
                                            mealName: snack2High[position],
                                            mealCal: snack2HighKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            snack2HighKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        snack2HighKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    snack2HighKcal[position];
                                              });
                                            },
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  mealTextWidget(whichMeal: "Dinner"),
                                  Container(
                                    height: 190,
                                    child: ListView.builder(
                                      itemCount: dinnerHigh.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        if (double.parse(bmi) <= 18.5) {
                                          return perMealWidget(
                                            mealName: dinnerLow[position],
                                            mealCal: dinnerLowKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            dinnerLowKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        dinnerLowKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    dinnerLowKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 18.5 &&
                                            double.parse(bmi) <= 25) {
                                          return perMealWidget(
                                            mealName: dinnerNormal[position],
                                            mealCal: dinnerNormalKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            dinnerNormalKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        dinnerNormalKcal[
                                                            position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    dinnerNormalKcal[position];
                                              });
                                            },
                                          );
                                        } else if (double.parse(bmi) > 25) {
                                          return perMealWidget(
                                            mealName: dinnerHigh[position],
                                            mealCal: dinnerHighKcal[position],
                                            minusFunction: () {
                                              setState(() {
                                                yourIntake -
                                                            dinnerHighKcal[
                                                                position] >=
                                                        0
                                                    ? yourIntake -=
                                                        dinnerHighKcal[position]
                                                    : null;
                                              });
                                            },
                                            addFunction: () {
                                              setState(() {
                                                yourIntake +=
                                                    dinnerHighKcal[position];
                                              });
                                            },
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BottomWidgetPlacer(
                      firstText: "YOUR INTAKE",
                      secondText: "in Calories",
                      onChangeFunction: (String value) {
                        textField = value;
                      },
                      minusOnPress: () {
                        setState(() {
                          if (yourIntake - int.parse(textField) >= 0) {
                            yourIntake -= int.parse(textField);
                          }
                        });
                      },
                      addOnPress: () {
                        setState(() {
                          if (textField != null) {
                            yourIntake += int.parse(textField);
                          }
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          color: KBackGroundColor,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () {
                              firestoreInstance
                                  .collection("users")
                                  .doc(_auth.uid)
                                  .set({
                                'date': {
                                  getCurrentDate(): {
                                    'data': {
                                      "yourIntake": yourIntake,
                                    }
                                  }
                                }
                              }, SetOptions(merge: true));
                              Navigator.pop(context);
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              "DONE",
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
////
