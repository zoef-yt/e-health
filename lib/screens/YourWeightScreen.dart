import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:e_health/screens/homePageFile.dart';
import 'package:e_health/methods/methods.dart';

class YourWeightScreen extends StatelessWidget {
  static String id = "yourWeightScreen";
  @override
  Widget build(BuildContext context) {
    return yourWeightScreen();
  }
}

class yourWeightScreen extends StatefulWidget {
  @override
  _yourWeightScreenState createState() => _yourWeightScreenState();
}

class _yourWeightScreenState extends State<yourWeightScreen> {
  String tempWeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: backgroundCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "RECALCULATE WEIGHT",
                  style: TextStyle(
                      color: KwidgetColor,
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Spacer(),
              Column(
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
                            if (tempWeight != null) {
                              weight = tempWeight;
                              bmi = getBMI(double.parse(height),
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
    );
  }
}
