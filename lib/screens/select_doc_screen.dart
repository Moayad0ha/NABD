import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/screens/report_view.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import '../model/share.dart';
import 'home_screen.dart';
import 'ocr_screen.dart';

class SelectDocScreen extends StatefulWidget {
  var rep_id;
  var user_id;
  var user_name;
  SelectDocScreen(this.rep_id,this.user_id,this.user_name);


  static String id = 'select_doc_screen';
  @override
  _SelectDocScreenState createState() => _SelectDocScreenState(rep_id,user_id,user_name);
}

class _SelectDocScreenState extends State<SelectDocScreen> {
  late dynamic doctors;
  late List doc;
  var rep_id;
  var user_id;
  var user_name;
  _SelectDocScreenState(this.rep_id,this.user_id,this.user_name);

  @override
  void initState() {
    super.initState();
    getDoctors().whenComplete(() {
      setState(() {});
    });
  }

  Future getDoctors() async {
    final _firebase = FirebaseFirestore.instance;
    doctors = (await _firebase
        .collection('users').where("type", isEqualTo: 'doctor').where("approved", isEqualTo: true)
        .get());
    print(
        '*************************************************************************');
    print(doctors.size);
    doc = doctors.docs;
    print(doc[0].reference);
    print(doc[0].id);
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
                  'Doctors',
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
                        child: ListView(
                          children: [
                            if (doctors.size >= 1)
                              for (var i = 1; i <= doctors.size; i++)
                                Doc_list(rep_id, doc[i - 1],user_id,user_name),
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

class Doc_list extends StatelessWidget {
  var rep_id;
  late var doc;
  var user_id;
  var user_name;
  Doc_list(this.rep_id, this.doc,this.user_id,this.user_name);

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
                shareData(rep_id,doc.id,user_id,user_name);
              },
              child: Expanded(
                child: Text(
                  doc.data()['name'],
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Londrina',
                      color: Color(0xff000000)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
