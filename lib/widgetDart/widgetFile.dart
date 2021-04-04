import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';

class WidgetPlacer extends StatelessWidget {
  // ignore: non_constant_identifier_names
  WidgetPlacer({this.FirstTxt, this.SecondTxt, this.function, this.colors});
  // ignore: non_constant_identifier_names
  final String FirstTxt;
  // ignore: non_constant_identifier_names
  final String SecondTxt;
  final Function function;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: widgetBoxDec,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  FirstTxt,
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                SecondTxt,
                style: TextStyle(fontFamily: 'WorkSans', color: colors),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class backgroundCard extends StatelessWidget {
  backgroundCard({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        decoration: ContainerboxDecoration,
        child: child,
      ),
    );
  }
}

class descWidget extends StatelessWidget {
  descWidget({this.Texts});
  final String Texts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
      child: Center(
        child: Text(
          Texts,
          style: TextStyle(color: KwidgetColor),
        ),
      ),
    );
  }
}

//BOTTOM Widget Placer

class BottomWidgetPlacer extends StatelessWidget {
  BottomWidgetPlacer({
    this.secondText,
    this.firstText,
    this.minusOnPress,
    this.addOnPress,
    this.onChangeFunction,
  });
  final String firstText;
  final String secondText;
  final Function minusOnPress;
  final Function addOnPress;
  final Function onChangeFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: widgetBoxDec,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      firstText,
                      style: TextStyle(
                          fontSize: 20,
                          color: KContainerColour,
                          fontFamily: "WorkSans",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    secondText,
                    style: TextStyle(
                        fontSize: 15,
                        color: KContainerColour,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: minusOnPress,
                child: Icon(
                  Icons.remove,
                  size: 50,
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintStyle: TextStyle(
                      color: KwidgetColor,
                      fontFamily: "WorkSans",
                    ),
                  ),
                  onChanged: onChangeFunction,
                ),
              ),
              InkWell(
                onTap: addOnPress,
                child: Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// meal text widget

// ignore: camel_case_types
class mealTextWidget extends StatelessWidget {
  mealTextWidget({this.whichMeal});
  final String whichMeal;

  @override
  Widget build(BuildContext context) {
    return Text(
      whichMeal,
      style: TextStyle(
          color: KwidgetColor,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
  }
}
//  mealTextWidget

class perMealWidget extends StatelessWidget {
  perMealWidget(
      {this.mealName,
      this.mealCal,
      this.hasSize,
      this.minusFunction,
      this.addFunction});
  final Function addFunction;
  final Function minusFunction;
  final String mealName;
  final int mealCal;
  final bool hasSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: widgetBoxDec,
        width: 300,
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                mealName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    color: KContainerColour,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: minusFunction,
                  child: CircleAvatar(
                      backgroundColor: KBackGroundColor,
                      foregroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.remove, size: 50)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$mealCal Kcal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: KContainerColour,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: addFunction,
                  child: CircleAvatar(
                      backgroundColor: KBackGroundColor,
                      foregroundColor: Colors.white,
                      radius: 25,
                      child: Icon(Icons.add, size: 50)),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class exerciseWidget extends StatelessWidget {
  exerciseWidget(
      {this.workoutName, this.kcal, this.minusFunction, this.addFunction});
  final Function addFunction;
  final Function minusFunction;
  final int kcal;
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
      child: Container(
        decoration: widgetBoxDec,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              InkWell(
                onTap: minusFunction,
                child: CircleAvatar(
                  backgroundColor: KBackGroundColor,
                  foregroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.remove, size: 50),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "10 $workoutName",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: KContainerColour,
                          fontFamily: "WorkSans",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "$kcal Kcal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: KContainerColour,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: addFunction,
                child: CircleAvatar(
                  backgroundColor: KBackGroundColor,
                  foregroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.add, size: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
