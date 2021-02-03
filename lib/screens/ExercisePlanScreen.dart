import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/homePageFile.dart';

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
  @override
  Widget build(BuildContext context) {
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
                      itemBuilder: (BuildContext context, int position) {
                        return exerciseWidget(
                          workoutName: workoutName[position],
                          kcal: kcalPerWorkout[position],
                          minusFunction: () {
                            setState(
                              () {
                                if (caloriesBurned - kcalPerWorkout[position] >
                                    0) {
                                  caloriesBurned =
                                      caloriesBurned - kcalPerWorkout[position];
                                }
                              },
                            );
                          },
                          addFunction: () {
                            setState(
                              () {
                                caloriesBurned =
                                    caloriesBurned + kcalPerWorkout[position];
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
