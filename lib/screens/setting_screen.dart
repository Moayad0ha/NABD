import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nabd/model/toast.dart';
import 'package:nabd/screens/login_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import 'about_screen.dart';
import 'home_screen.dart';


class SettingScreen extends StatefulWidget {
  static String id = 'setting_screen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>{
  final _auth = FirebaseAuth.instance;
   static var email;
   static var user;

  void initState(){
    user = _auth.currentUser;
    email = user?.email;
      setState(() {
      });

  }

  bool _emailIsEnable = false;
  TextEditingController _emailController = TextEditingController(text: email);
  TextEditingController _passController = TextEditingController(text: 'password');

  Future<void> saveData() async{
    if(email == _emailController.text){
      if(_passController.text == 'password'){

      }else if(_passController.text.length < 6){
        toast('password must be more than 6');
      }else if(_passController.text.length > 6){
        user.updatePassword(_passController.text).then(
                (value) => toast('data saved'));
      }
    }else if(_emailController.text != email){
      if(_passController.text == 'password'){
        user.updateEmail(_emailController.text).then(
              (value) => toast('data saved'),
        );
      }else if(_passController.text.length < 6){
        toast('password must be more than 6');
      }else if(_passController.text.length > 6){
        user.updateEmail(_emailController.text).updatePassword(_passController.text).then(
              (value) => toast('data saved'),
        );
      }
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut().then((value) => Navigator.pushNamed(context, LoginScreen.id));
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
                  'Settings',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Londrina',
                      color: Color(0xffE13C6C)),
                ),
                SizedBox(
                  width: 60,
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
        child: Column(
          children: [
            Expanded(
              child: Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xffF0C5D7),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 14.0, color: Color(0xFFF0C5D7)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                controller: _emailController,
                                  enabled: true,
                                        style: TextStyle(fontSize: 20,fontFamily: 'Londrina',color: Color(0xff030303)),
                                ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {})
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xffF0C5D7),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 14.0, color: Color(0xFFF0C5D7)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _passController,
                                        enabled: true,
                                        style: TextStyle(fontSize: 20,fontFamily: 'Londrina',color: Color(0xff030303)),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {})
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                decoration: BoxDecoration(
                                  color: Color(0xffF0C5D7),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 14.0, color: Color(0xFFF0C5D7)),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, AboutScreen.id);
                                    },
                                      child: Expanded(
                                        child: Text(
                                          'About us',
                                          style: TextStyle(fontSize: 20,fontFamily: 'Londrina',color: Color(0xff030303)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        saveData();
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: 'Londrina',
                            color: Color(0xffe13c6c),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        _signOut();
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'logout',
                        style: TextStyle(
                            fontFamily: 'Londrina',
                            color: Color(0xffe13c6c),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
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
    );
  }

}