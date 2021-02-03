import 'package:flutter/material.dart';
import 'package:e_health/screens/homePageFile.dart';

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
