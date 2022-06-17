import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  navigate() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, LoginScreen.id);
    });
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'logo',
        child: Center(
          child: Container(
            child: Image.asset(
                'images/appbar2.png',
                scale: 0.6,
            ),
          ),
        ),
      ),
    );
  }

}