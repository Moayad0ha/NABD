
import 'package:flutter/material.dart';


class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  static String id = 'waiting_screen';

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
          child: Center(
            child: Text(
              "Thank you for creating an account you data is being revised, once it's activated you will be able to use it.",
              style: TextStyle(fontFamily: 'Londrina',color: Colors.white,fontSize: 24),
            ),
          ),
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
