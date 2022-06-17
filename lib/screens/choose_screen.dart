import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nabd/screens/registration_doc_screen.dart';
import 'package:nabd/screens/registration_screen.dart';

class ChooseScreen extends StatefulWidget {
  static String id = 'choose_screen';
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'choose your status',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Londrina',
                        color: Color(0xffffffff)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Stack(overflow: Overflow.visible, children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RegistrationDocScreen.id),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 20, color: Color(0xFFFffffff)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "images/doctor.svg",
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Doctor',
                                style: TextStyle(
                                    fontSize: 43,
                                    fontFamily: 'Londrina',
                                    color: Color(0xffe13c6c)),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                        top: -25,
                        left: 0,
                        right: 0,
                        child: //SvgPicture.asset("images/heart.svg",width: 50,height: 50,)
                            Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'images/heart.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          margin: EdgeInsetsDirectional.fromSTEB(
                            140,
                            0,140,0
                          ),
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(2000)),
                        ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Stack(overflow: Overflow.visible, children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RegistrationScreen.id),
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                            border:
                            Border.all(width: 20, color: Color(0xFFFffffff)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "images/patient.svg",
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Patient',
                                style: TextStyle(
                                    fontSize: 43,
                                    fontFamily: 'Londrina',
                                    color: Color(0xffe13c6c)),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                      top: -25,
                      left: 0,
                      right: 0,
                      child: //SvgPicture.asset("images/heart.svg",width: 50,height: 50,)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/heart.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        margin: EdgeInsetsDirectional.fromSTEB(
                            140,
                            0,140,0
                        ),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(2000)),
                      ),
                    ),
                  ]),
                ),
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
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              child: Image.asset(
                'images/appbar2.png',
                alignment: Alignment(-0.3, 0.5),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(190),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
//2188
