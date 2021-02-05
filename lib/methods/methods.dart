import 'package:flutter/material.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'ConstantsFile.dart';

String getBMI(double height, double weight) {
  double tempHeight = height / 100;
  print(weight);
  double BMI = weight / (tempHeight * tempHeight);
  if (BMI <= 18.5) {
    bmiMessage = "You are UNDERWEIGHT 🍔";
    bmiColor = Colors.yellow;
  } else if (BMI > 18.5 && BMI <= 25) {
    bmiMessage = "Wow! NORMAL WEIGHT 🌟  ";
    bmiColor = Colors.green;
  } else if (BMI > 25) {
    bmiMessage = "You are OVERWEIGHT 🥦";
    bmiColor = Colors.red;
  }
  return BMI.toStringAsFixed(1);
}

Future<void> showMyDialog(context, e) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: KBackGroundColor,
        title: Text('Oh No!....'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$e'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Okay',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
