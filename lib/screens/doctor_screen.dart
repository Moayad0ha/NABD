
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/screens/screens_from_users.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_doc_screen.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  static String id = 'doctor_screen';

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
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
                Image.asset('images/doctor.png',scale: 50,),
                SizedBox(width: 80,),
                Text('Doctors',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffE13C6C)),),
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
                                  Get.to(ScreenFromUsers());
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
                                        "images/file-sharing.png",
                                        height: 70,
                                        width: 70,),
                                      SizedBox(height: 7,),
                                      Text(
                                        'Shared files',
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
                                  Get.to(SettingScreen());
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
                                        "images/settings.png",
                                        height: 70,
                                        width: 70,),
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
                        //Navigator.pushNamed(context, SettingScreen.id);
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
                        //Navigator.pushNamed(context, ShareScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share,color: Colors.white,),
                          Text('shared files', style: TextStyle(color: Colors.white,),),
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
