import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'timelineScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class settingPage extends StatefulWidget {
  static String id = "settingPage";
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: KBackGroundColor,
        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.fastOutSlowIn,
        index: 0,
        height: 60,
        onTap: (index) {
          if (index == 0) {}
          if (index == 1) {
            Future.delayed(
              Duration(milliseconds: 250),
              () {
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            );
          }
          if (index == 2) {
            Future.delayed(Duration(milliseconds: 250), () {
              Navigator.of(context).pushNamed(timeLineScreen.id);
            });
          }
        },
        items: <Widget>[
          Icon(Icons.face_rounded, size: 30, color: KwidgetColor),
          Icon(Icons.home_rounded, size: 30, color: KwidgetColor),
          Icon(Icons.calendar_today, size: 30, color: KwidgetColor),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            decoration: ContainerboxDecoration,
          ),
        ),
      ),
    );
  }
}
