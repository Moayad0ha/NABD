
import 'package:flutter/material.dart';
import 'package:nabd/screens/user_sup_screen.dart';

import 'doc_sup_screen.dart';


class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  static String id = 'admin_screen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                Image.asset('images/supervisor.png',scale: 25,),
                SizedBox(width: 80,),
                Text('Admins',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffE13C6C)),),
                SizedBox(width: 70,),
                Image.asset('images/appbar2.png',scale: 1.3,),
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
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox()
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  print('done');
                                  Navigator.pushNamed(context, UserSupScreen.id);
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(24,30,24,30),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF0C5D7),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 7.0, color: Color(0xFFF0C5D7)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/patient.png",
                                        height: 85,
                                        width: 85,),
                                      SizedBox(height: 7,),
                                      Text(
                                        'users',
                                        style: TextStyle(
                                          fontFamily: 'Londrina',
                                          color: Color(0xff1B6CB7),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, DocSupScreen.id);
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(24,30,24,30),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF0C5D7),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 7.0, color: Color(0xFFF0C5D7)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/doctor.png",
                                        height: 85,
                                        width: 85,),
                                      SizedBox(height: 7,),
                                      Text(
                                        'Doctors',
                                        style: TextStyle(
                                          fontFamily: 'Londrina',
                                          color: Color(0xff1B6CB7),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: SizedBox()
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
