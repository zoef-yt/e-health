import 'package:flutter/material.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'ConstantsFile.dart';

String getBMI(double height, double weight) {
  double tempHeight = height / 100;
  print(weight);
  double BMI = weight / (tempHeight * tempHeight);
  return BMI.toStringAsFixed(1);
}

String getBmiMessage(double height, double weight) {
  double BMI = double.parse(getBMI(height, weight));
  if (BMI <= 18.5) {
    bmiColor = Colors.yellow;
    return "You are UNDERWEIGHT 🍔";
  } else if (BMI > 18.5 && BMI <= 25) {
    bmiColor = Colors.green;
    return "Wow! NORMAL WEIGHT 🌟  ";
  } else if (BMI > 25) {
    bmiColor = Colors.red;
    return "You are OVERWEIGHT 🥦";
  }
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
