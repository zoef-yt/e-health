import 'package:flutter/material.dart';

// const Color KwidgetColor = Color(0xFFffd66b);
const Color KwidgetColor = Color(0xFF252525);
// const Color KBackGroundColor = Color(0xFF61b15a);
const Color KBackGroundColor = Color(0xFF590995);
const Color KContainerColour = Colors.white;
const BoxDecoration ContainerboxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black54,
      blurRadius: 5.0, // soften the shadow
      spreadRadius: 2.0, //extend the shadow
      offset: Offset(
        5.0, // Move to right 10  horizontally
        5.0,
      ),
    )
  ],
  // color: Color(0xFF1b1919),
  color: KContainerColour,
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

final BoxDecoration widgetBoxDec = BoxDecoration(
  boxShadow: [
    BoxShadow(
        color: Colors.black54,
        blurRadius: 5.0, // soften the shadow
        spreadRadius: 2.0, //extend the shadow
        offset: Offset(
          5.0, // Move to right 10  horizontally
          5.0,
        ))
  ],
  color: KwidgetColor,
  // color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
  border: Border.all(color: KBackGroundColor, width: 7),
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: KBackGroundColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: KBackGroundColor, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
