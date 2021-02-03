import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/RegistrationScreen.dart';
import 'package:e_health/screens/BMIScreen.dart';
import 'package:e_health/screens/YourWeightScreen.dart';
import 'package:e_health/screens/GoalScreen.dart';
import 'package:e_health/screens/DietPlanScreen.dart';
import 'package:e_health/screens/ExercisePlanScreen.dart';

String userName = "New User";
String height;
String weight;
String goalWeight;
String bmi;
String bmiMessage;
Color bmiColor;
int yourIntake = 0;
int caloriesBurned = 0;
bool isUserRegister = false;

class MainHomePage extends StatefulWidget {
  static String id = "MainHomePage";
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void getValue() {
    setState(() {});
  }

  onGoBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            decoration: ContainerboxDecoration,
            child: Padding(
              padding: EdgeInsets.only(left: 8, top: 80, right: 8, bottom: 5),
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
                      FirstTxt: bmi != null ? bmi : "Register",
                      SecondTxt: bmiMessage != null ? bmiMessage : "YOUR BMI",
                      colors: bmiColor,
                      function: () {
                        Navigator.pushNamed(
                                context,
                                isUserRegister
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
                                isUserRegister ? "$weight kg" : "Register",
                            SecondTxt: "Your Weight",
                            function: () {
                              Navigator.pushNamed(
                                      context,
                                      isUserRegister
                                          ? YourWeightScreen.id
                                          : RegistrationScreen.id)
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
                                isUserRegister ? "$goalWeight kg" : "Register",
                            SecondTxt: "Your Goal",
                            function: () {
                              Navigator.pushNamed(
                                      context,
                                      isUserRegister
                                          ? GoalScreen.id
                                          : RegistrationScreen.id)
                                  .then((value) => onGoBack());
                            },
                          ),
                        ),
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
                          SecondTxt:
                              bmi != null ? "Diet Plan" : "To Get Your Diet",
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
                          FirstTxt: bmi != null ? "🏋️" : "🏋️ Register",
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
                            Navigator.pushNamed(context, ExercisePage.id)
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
}

getCurrentDate() {
  String finalDate;
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
  finalDate = formattedDate.toString();
  return finalDate;
}
