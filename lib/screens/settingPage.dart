import 'package:e_health/widgetDart/widgetFile.dart';
import 'package:flutter/material.dart';
import 'package:e_health/methods/ConstantsFile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'timelineScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class settingPage extends StatefulWidget {
  static String id = "";
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  String userName = "New User";
  String tempName;
  final _auth = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserInfo() async {
    final info =
        await firestoreInstance.collection("users").doc(_auth.uid).get();
    userName = await info.data()['Name'];
    print(userName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(home: Center(child: Text("${snapshot.error}")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    decoration: ContainerboxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 80, right: 8, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Hello, $userName",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: KwidgetColor,
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          descWidget(Texts: "Change Username"),
                          SizedBox(height: 10),
                          TextField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: KBackGroundColor,
                              fontFamily: "WorkSans",
                            ),
                            onChanged: (value) {
                              tempName = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'New Username',
                              hintStyle: TextStyle(
                                color: KwidgetColor,
                                fontFamily: "WorkSans",
                              ),
                            ),
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
                                        if (tempName != null) {
                                          firestoreInstance
                                              .collection("users")
                                              .doc(_auth.uid)
                                              .set(
                                            {'Name': tempName},
                                            SetOptions(merge: true),
                                          );
                                        }
                                      });
                                    },
                                    minWidth: 200.0,
                                    height: 42.0,
                                    child: Text(
                                      "Done",
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
              ),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: backgroundCard(
                child: ModalProgressHUD(
                  inAsyncCall: true,
                  color: KwidgetColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
