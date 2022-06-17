import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nabd/screens/choose_screen.dart';
import 'package:nabd/screens/reset_screen.dart';

import '../model/login.dart';
import 'home_screen.dart';



class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title:Text('login',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffffffff)),),),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter,
                end:
                Alignment(0.0, 0.0),
                colors: <Color>[
                  Color(0xfffe7fb7),
                  Color(0xffe13c6c)
                ],),
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,150.0,0,0),
                child: Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(fontFamily: 'Londrina',color: Colors.white,fontSize: 24),
                    )
                ),
              ),
               Image.asset('images/user1.png'),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
              ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
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
                      onPressed: (){
                        db_conn(_nameController.text,_passController.text);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Login',
                        style: TextStyle(fontFamily:'Londrina',color: Color(0xffe13c6c),fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,10),
                child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'create account',
                      style: TextStyle(
                          fontFamily:'Londrina',
                          fontSize:18,
                          color: Colors.white,
                          decoration: TextDecoration.underline
                      ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(context, ChooseScreen.id),
                      )
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,200),
                child: Center(
                  child: RichText(
                      text: TextSpan(
                        text: 'forgot password?',
                        style: TextStyle(
                            fontFamily:'Londrina',
                            fontSize:18,
                            color: Colors.white,
                            decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamed(context, ResetScreen.id),
                      )
                  ),
                ),
              ),

            ]
    )
          ),
            Positioned(
              top: -80,
              right: -60,
              child: Hero(
                tag: 'logo',
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('images/appbar2.png',alignment: Alignment(-0.3,0.5),),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(190),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}