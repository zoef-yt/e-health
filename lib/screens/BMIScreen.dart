import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/methods/methods.dart';

class BMIScreen extends StatelessWidget {
  static String id = "BmiScreen";
  @override
  Widget build(BuildContext context) {
    return bmiScreen();
  }
}

class bmiScreen extends StatefulWidget {
  @override
  _bmiScreenState createState() => _bmiScreenState();
}

class _bmiScreenState extends State<bmiScreen> {
  String tempWeight;
  String tempHeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: backgroundCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "CALCULATE BMI",
                    style: TextStyle(
                        color: KwidgetColor,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          descWidget(Texts: "ENTER YOUR WEIGHT"),
                          TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: KBackGroundColor,
                              fontFamily: "WorkSans",
                            ),
                            onChanged: (value) {
                              tempWeight = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Weight in kg',
                                hintStyle: TextStyle(
                                  color: KwidgetColor,
                                  fontFamily: "WorkSans",
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          descWidget(Texts: "ENTER YOUR HEIGHT"),
                          TextField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: KBackGroundColor,
                              fontFamily: "WorkSans",
                            ),
                            onChanged: (value) {
                              tempHeight = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Height in cm',
                                hintStyle: TextStyle(
                                  color: KwidgetColor,
                                  fontFamily: "WorkSans",
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        elevation: 5.0,
                        color: KBackGroundColor,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (tempWeight != null && tempHeight != null) {
                                weight = tempWeight;
                                height = tempHeight;
                                bmi = getBMI(double.parse(tempHeight),
                                    double.parse(tempWeight));

                                Navigator.pop(
                                  context,
                                );
                              }
                            });
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            "Recalculate",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
