import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'doc_sup_screen.dart';
import 'mod_user_screen.dart';

class UserSupScreen extends StatefulWidget {
  const UserSupScreen({Key? key}) : super(key: key);

  static String id = 'user_sup_screen';

  @override
  _UserSupScreenState createState() => _UserSupScreenState();
}

class _UserSupScreenState extends State<UserSupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getusers();
  }

  var data;
  late List dat;
  Future getusers() async {
    print("hi");
    final _firebase = FirebaseFirestore.instance;
    data = (await _firebase
        .collection('users')
        .where("type", isEqualTo: 'user')
        .get());
    dat = data.docs;
    //Map d = dat[0].data();
    setState(() {});
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
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              Container(
                child: Expanded(
                  child: ListView(
                    children: [
                      if (data.size >= 1) ...[for (var ds in dat) Each_user(ds)]
                    ],
                  ),
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

class Each_user extends StatelessWidget {
  late var data;

  Each_user(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => ModUserScreen(data));
      },
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                          data['name'],
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Londrina',
                              color: Color(0xff000000)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
