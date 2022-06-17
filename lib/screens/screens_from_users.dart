import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/model/toast.dart';
import 'package:nabd/screens/report_view.dart';
import 'package:nabd/screens/report_view_doc.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_doc_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import 'home_screen.dart';
import 'ocr_screen.dart';

class ScreenFromUsers extends StatefulWidget {
  static String id = 'screen_from_users';
  @override
  _ScreenFromUsersState createState() => _ScreenFromUsersState();
}

class _ScreenFromUsersState extends State<ScreenFromUsers> {
  late dynamic reports;
  late dynamic users;
  late List rep;
  Set user_list = {};

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
    final uid = user?.uid;
    final _firebase = FirebaseFirestore.instance;
    reports = (await _firebase
        .collection('users')
        .doc(uid)
        .collection('reports')
        .get());
    print(
        '*************************************************************************');
    print(reports.size);
    rep = reports.docs;
    print(rep[0].reference);
    print(rep[0].id);
    print(
        '*************************************************************************');

    for(var re in rep){
        user_list.add(re.data()['user_id']);
    }
    print(user_list);

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
                  width: 55,
                ),
                Image.asset(
                  'images/appbar2.png',
                  scale: 1.5,
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
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            if (reports.size >= 1)
                              for(var use in user_list)
                                FutureBuilder(
                                  future: report(use),
                                    builder:(context, snapshot) {
                                      final name = snapshot.data;
                                      return report_result(name);
                                    },)
                                // report_result(use)
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
                          Navigator.pushNamed(context, HomeScreen.id);
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

Future<List> report(id) async {
  var usern;
  final _firebase = FirebaseFirestore.instance;
  var user = (await _firebase
      .collection('users')
      .doc(id)
      .get());
   usern = user.data()!['name'];
   return [usern,id];
}

class report_result extends StatelessWidget {
  late var user_data;
  report_result(this.user_data);

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
                Get.to(() => ShareScreenDoc(user_data[1]));
                // if (data.data()['permission_period'].toDate().compareTo(now) >
                //     0) {
                //   Get.to(() => ShareScreenDoc(data));
                // } else {
                //   toast('permission denied');
                // }
              },
              child: Expanded(
                  child: user_data[0] != null
                      ? Text(
                    user_data[0],
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Londrina',
                        color: Color(0xff000000)),
                  )
                      : Text('user',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Londrina',
                          color: Color(0xff000000)))),
            ),
          ],
        ),
      ),
    );
  }
}
