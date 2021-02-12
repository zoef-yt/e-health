import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ExercisePage extends StatelessWidget {
  static String id = "exercisePlan";

  @override
  Widget build(BuildContext context) {
    return exercisePlanScreen();
  }
}

class exercisePlanScreen extends StatefulWidget {
  @override
  _exercisePlanScreenState createState() => _exercisePlanScreenState();
}

List<String> workoutName = [
  "Lunges",
  'Pushups',
  'Squats',
  'Burpees',
  'Side planks',
  'Planks',
  'Glute bridge',
  'Torso Twist',
  'Step Ups',
  'Squat Jumps',
  'Side Crunch',
  'Scissor Kicks',
  'Sit Ups',
  'Punches',
  'Pull Ups',
  'High Knees',
  'Bicep Curls',
  'Deadlifts',
  'Pull Downs',
  'Calf Raises'
];
List<int> kcalPerWorkout = [
  4,
  6,
  6,
  9,
  6,
  7,
  4,
  3,
  5,
  7,
  6,
  7,
  8,
  6,
  10,
  6,
  12,
  19,
  8,
  4
];
String textField;

class _exercisePlanScreenState extends State<exercisePlanScreen> {
  int caloriesBurned = 0;
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
    // caloriesBurned =
    //     await info.data()['date'][getCurrentDate()]['data']['youBurned'];
    print("done");
  }

  Future<String> getUserInfo2() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    caloriesBurned =
        await info.data()['date'][getCurrentDate()]['data']['youBurned'];
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          "EXERCISE PLAN",
                          style: TextStyle(
                              color: KwidgetColor,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            caloriesBurned >= 1
                                ? "Today you lost ${caloriesBurned}🔥"
                                : "Start Workout",
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
                            decoration: BoxDecoration(
                              color: Color(0xFFf5f4f4),
                            ),
                            child: ListView.builder(
                              itemCount: workoutName.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return exerciseWidget(
                                  workoutName: workoutName[position],
                                  kcal: kcalPerWorkout[position],
                                  minusFunction: () {
                                    setState(
                                      () {
                                        if (caloriesBurned -
                                                kcalPerWorkout[position] >
                                            0) {
                                          caloriesBurned = caloriesBurned -
                                              kcalPerWorkout[position];
                                        }
                                      },
                                    );
                                  },
                                  addFunction: () {
                                    setState(
                                      () {
                                        caloriesBurned = caloriesBurned +
                                            kcalPerWorkout[position];
                                      },
                                    );
                                  },
                                );
                              },
                            ),
// child: ListView.builder(
//     itemCount: testMap.length,
//     itemBuilder: (BuildContext context, int pos) {
//       return exerciseWidget(
//           workoutName: testMap.keys.toString());
//     }),
                          ),
                        ),
                      ),
                      BottomWidgetPlacer(
                        firstText: "Physically Active",
                        secondText: "In Minutes",
                        onChangeFunction: (String value) {
                          textField = value;
                        },
                        minusOnPress: () {
                          setState(() {
                            if (caloriesBurned - int.parse(textField) > 0 &&
                                textField != null) {
                              caloriesBurned -= int.parse(textField);
                            }
                          });
                        },
                        addOnPress: () {
                          setState(() {
                            if (textField != null) {
                              caloriesBurned += int.parse(textField);
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
                                        "youBurned": caloriesBurned,
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
        });
  }
}

//
