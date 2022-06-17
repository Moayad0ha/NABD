import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nabd/screens/user_sup_screen.dart';

import 'doc_sup_screen.dart';

class ModDocScreen extends StatefulWidget {
  var data;

  ModDocScreen(this.data);

  @override
  _ModDocScreenState createState() => _ModDocScreenState(data);
}

class _ModDocScreenState extends State<ModDocScreen> {
  var data;
  _ModDocScreenState(this.data);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  approve(id) async {
    await _firebase.collection('users').doc(id).update({
      'approved': true,
    });
  }

  delete(id) async {
    await _firebase.collection('users').doc(id).delete().then((value) => () {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(
        '********************************************************************');
    print(data.data());
    print(data.id);
    Map d = data.data();
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
                  'images/supervisor.png',
                  scale: 25,
                ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  'Users',
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
                  scale: 1.1,
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
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 7.0, color: Color(0xFFF0C5D7)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  d['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Londrina',
                                      color: Color(0xffe13c6c)),
                                ),
                                if (d['approved'] == true) ...[
                                  Text(
                                    'approved',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Londrina',
                                        color: Color(0xff1B6CB7)),
                                  ),
                                ] else ...[
                                  Text(
                                    'not approved',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Londrina',
                                        color: Color(0xff1B6CB7)),
                                  ),
                                ],
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'email:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Londrina',
                                              color: Color(0xff1B6CB7)),
                                        ),
                                        Text(
                                          d['email'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Londrina',
                                              color: Color(0xffe13c6c)),
                                        ),
                                        Image.network(
                                          d['certifcation'],
                                          scale: 3,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Material(
                                              elevation: 5.0,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  approve(data.id);
                                                },
                                                minWidth: size.width * 0.25,
                                                height: size.height * 0.05,
                                                child: Text(
                                                  'Approve',
                                                  style: TextStyle(
                                                      fontFamily: 'Londrina',
                                                      color: Color(0xffe13c6c),
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Material(
                                              elevation: 5.0,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  // delete(data.id);
                                                },
                                                minWidth: size.width * 0.25,
                                                height: size.height * 0.05,
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontFamily: 'Londrina',
                                                      color: Color(0xffe13c6c),
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ])),
                    ),
                  ),
                ],
              ),
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
                        Navigator.pushNamed(context, UserSupScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          Text(
                            'users',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DocSupScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          Text(
                            'doctors',
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
