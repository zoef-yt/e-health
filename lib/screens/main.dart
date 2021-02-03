import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/screens/RegistrationScreen.dart';
import 'package:e_health/Screens/BMIScreen.dart';
import 'package:e_health/screens/YourWeightScreen.dart';
import 'package:e_health/screens/GoalScreen.dart';
import 'package:e_health/screens/DietPlanScreen.dart';
import 'package:e_health/screens/ExercisePlanScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF222831),
        accentColor: KwidgetColor,
        scaffoldBackgroundColor: KBackGroundColor,
      ),
      // theme: ThemeData.dark(),
      initialRoute: MainHomePage.id,
      routes: {
        MainHomePage.id: (context) => MainHomePage(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        BMIScreen.id: (context) => BMIScreen(),
        YourWeightScreen.id: (context) => YourWeightScreen(),
        GoalScreen.id: (context) => GoalScreen(),
        DietPlan.id: (context) => DietPlan(),
        ExercisePage.id: (context) => ExercisePage(),
      },
    );
  }
}
