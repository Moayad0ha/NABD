import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:nabd/screens/user_sup_screen.dart';

import 'doc_sup_screen.dart';
import 'edit_users.dart';

class ModUserScreen extends StatefulWidget {
  var data;

  ModUserScreen(this.data);

  @override
  _ModUserScreenState createState() => _ModUserScreenState(data);
}

class _ModUserScreenState extends State<ModUserScreen> {
  var data;
  _ModUserScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('********************************************************************');
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
                              border: Border.all(width: 7.0, color: Color(0xFFF0C5D7)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    d['name'],
                                    style: TextStyle(
                                        fontSize:18,
                                        fontFamily: 'Londrina',
                                        color: Color(0xffe13c6c)
                                    ),
                                  ),
                                  Text(
                                    d['national_id'],
                                    style: TextStyle(
                                        fontSize:18,
                                        fontFamily: 'Londrina',
                                        color: Color(0xff1B6CB7)
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Nationality:',
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xff1B6CB7)
                                            ),
                                          ),
                                          Text(
                                            d['nationality'],
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xffe13c6c)
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        children: [
                                          Text(
                                            'Birthday',
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xff1B6CB7)
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yMMMd().format(data['date_of_birth'].toDate()),
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xffe13c6c)
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        children: [
                                          Text(
                                            'blood type',
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xff1B6CB7)
                                            ),
                                          ),
                                          Text(
                                            d['blood_type'],
                                            style: TextStyle(
                                                fontSize:18,
                                                fontFamily: 'Londrina',
                                                color: Color(0xffe13c6c)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 36.0),
                                    child: Material(
                                      elevation: 5.0,
                                      color: Color(0xffe13c6c),
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: MaterialButton(
                                        onPressed: (){
                                          Get.to(() => EditUsers(data));
                                        },
                                        minWidth: 200.0,
                                        height: 42.0,
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(fontFamily:'Londrina',color: Color(0xffffffff),fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                        ),
                      )
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
                      onTap: (){
                        Navigator.pushNamed(context, UserSupScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white,),
                          Text('users',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, DocSupScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share,color: Colors.white,),
                          Text('doctors', style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,
            end:
            Alignment(0.0, 0.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xfffe7fb7),
              Color(0xffe13c6c)
            ],),
        ),
      ),
    );
  }
}
