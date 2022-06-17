import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/screens/report_view.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import 'home_screen.dart';
import 'ocr_screen.dart';

class ReportScreen extends StatefulWidget {
  static String id = 'report_screen';
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  dynamic? reports;
  dynamic? userdata;
  late List rep;
  late var uid;

  @override
  void initState() {
    super.initState();
    getReports().whenComplete(() {
          setState(() {});
        });
  }

  Future getReports() async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    uid = user?.uid;
    final _firebase = FirebaseFirestore.instance;
    userdata =  (await _firebase
        .collection('users')
        .doc(uid)
        .get());
    reports = (await _firebase
        .collection('users')
        .doc(uid)
        .collection('reports')
        .get());
    print(
        '*************************************************************************');
    print(userdata);
    print(userdata['name']);
    print(reports.size);
    rep = reports.docs;
    print(rep[0].reference);
    print(rep[0].id);
    print(
        '*************************************************************************');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          //elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'images/appbar1.png',
                  scale: 0.8,
                ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  'Report',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Londrina',
                      color: Color(0xffE13C6C)),
                ),
                SizedBox(
                  width: 70,
                ),
                Image.asset(
                  'images/appbar2.png',
                  scale: 1.3,
                ),
              ]),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListView(
                          children: [
                            if (reports.size >= 1)
                              ...[for (var i = 1; i <= reports.size; i++)
                                report_result(i, rep[i - 1],uid,userdata['name']),
                              ] else ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffF0C5D7),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 14.0, color: Color(0xFFF0C5D7)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'no reports',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Londrina',
                                              color: Color(0xffffffff)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]
                          ],
                        ))),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF975AB),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SettingScreen.id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            Text(
                              'settings',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ShareScreen.id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            Text(
                              'share',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, OcrScreen.id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.report,
                              color: Colors.white,
                            ),
                            Text(
                              'ocr',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            Text(
                              'home',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(
                0.0, 0.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[Color(0xfffe7fb7), Color(0xffe13c6c)],
          ),
        ),
      ),
    );
  }
}

class report_result extends StatelessWidget {
  var num;
  late var data;
  var user_id;
  var userna;
  report_result(this.num, this.data,this.user_id,this.userna);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF0C5D7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 14.0, color: Color(0xFFF0C5D7)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ReportView(data,user_id,userna));
              },
              child: Expanded(
                child: (data.data()['date'] != null)
                    ? Text(
                  '${data.data()['lab_name']} / ${data.data()['date']}',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Londrina',
                      color: Color(0xff000000)),
                )
                    : Text(
                  '${data.data()['lab_name']} / ---',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Londrina',
                      color: Color(0xff000000)),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
