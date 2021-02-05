import 'package:e_health/screens/loginScreen.dart';
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
import 'welcomeScreen.dart';
import 'userRegistrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return MaterialApp(
              home: Text("${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark().copyWith(
                primaryColor: Color(0xFF222831),
                accentColor: KwidgetColor,
                scaffoldBackgroundColor: KBackGroundColor,
              ),
              home: welcomeScreen(),
              initialRoute: WelcomeScreen.id,
              routes: {
                MainHomePage.id: (context) => MainHomePage(),
                WelcomeScreen.id: (context) => WelcomeScreen(),
                RegistrationScreen.id: (context) => RegistrationScreen(),
                BMIScreen.id: (context) => BMIScreen(),
                YourWeightScreen.id: (context) => YourWeightScreen(),
                GoalScreen.id: (context) => GoalScreen(),
                DietPlan.id: (context) => DietPlan(),
                ExercisePage.id: (context) => ExercisePage(),
                loginScreen.id: (context) => loginScreen(),
                userRegistrationScreen.id: (context) =>
                    userRegistrationScreen(),
              },
            );
          }

          return MaterialApp(
            home: Text("loading"),
          );
        });
  }
}
