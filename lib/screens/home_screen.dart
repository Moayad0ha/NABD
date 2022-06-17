import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nabd/screens/report_screen.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import 'ocr_screen.dart';


class HomeScreen extends StatefulWidget {
  Map d;
  HomeScreen(this.d);
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState(d);
}

class _HomeScreenState extends State<HomeScreen>{
  Map data;
  _HomeScreenState(this.data);

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
                Image.asset('images/appbar1.png',scale: 0.8,),
                SizedBox(width: 80,),
                Text('Home',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffE13C6C)),),
                SizedBox(width: 70,),
                Image.asset('images/appbar2.png',scale: 1.1,),
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
                                    data['name'],
                                    style: TextStyle(
                                        fontSize:18,
                                        fontFamily: 'Londrina',
                                        color: Color(0xffe13c6c)
                                    ),
                                  ),
                                  Text(
                                    data['national_id'],
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
                                            data['nationality'],
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
                                            data['blood_type'],
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
                                ]
                            )
                        ),
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                        child: GestureDetector(
                        onTap: (){
                  Navigator.pushNamed(context, OcrScreen.id);
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
                              Image.asset('images/ocr.png',scale: 0.8),
                              SizedBox(height: 7,),
                              Text(
                                'start OCR',
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
                  Navigator.pushNamed(context, ReportScreen.id);
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
                                Image.asset('images/thirdparty.png',scale: 0.8),
                                SizedBox(height: 7,),
                                Text(
                                  'My reports',
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, SettingScreen.id);
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
                                Image.asset('images/settings.png',scale: 0.8),
                                SizedBox(height: 7,),
                                Text(
                                  'Settings',
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
                          child:GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, ShareScreen.id);
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
                                Image.asset('images/filesharing.png',scale: 0.8),
                                SizedBox(height: 7,),
                                Text(
                                  'share data',
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
                        Navigator.pushNamed(context, SettingScreen.id);
                    },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white,),
                          Text('settings',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ShareScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share,color: Colors.white,),
                          Text('share', style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, OcrScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.report, color: Colors.white,),
                          Text('ocr',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home,color: Colors.white,),
                          Text('home',style: TextStyle(color: Colors.white,),),
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