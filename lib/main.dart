import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nabd/screens/about_screen.dart';
import 'package:nabd/screens/admin_screen.dart';
import 'package:nabd/screens/choose_screen.dart';
import 'package:nabd/screens/doc_ai.dart';
import 'package:nabd/screens/doc_sup_screen.dart';
import 'package:nabd/screens/doctor_screen.dart';
import 'package:nabd/screens/read_json.dart';
import 'package:nabd/screens/home_screen.dart';
import 'package:nabd/screens/login_screen.dart';
import 'package:nabd/screens/ocr_screen.dart';
import 'package:nabd/screens/registration_doc_screen.dart';
import 'package:nabd/screens/registration_screen.dart';
import 'package:nabd/screens/report_screen.dart';
import 'package:nabd/screens/reset_screen.dart';
import 'package:nabd/screens/select_doc_screen.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';
import 'package:nabd/screens/share_doc_screen.dart';
import 'package:nabd/screens/user_sup_screen.dart';
import 'package:nabd/screens/waiting_screen.dart';
import 'package:nabd/screens/welcome_screen.dart';

void main(){ 
  runApp(Nabd());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

class Nabd extends StatelessWidget {

  void initializeApp() async {
    print('initState');
    await Firebase.initializeApp().whenComplete(() {
      print("completed");
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeApp();


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (Context) => WelcomeScreen(),
        RegistrationScreen.id: (Context) => RegistrationScreen(),
        RegistrationDocScreen.id: (Context) => RegistrationDocScreen(),
        LoginScreen.id: (Context) => LoginScreen(),
        ChooseScreen.id: (Context) => ChooseScreen(),
        HomeScreen.id: (Context) => HomeScreen({}),
        OcrScreen.id: (Context) => OcrScreen(),
        SettingScreen.id: (Context) => SettingScreen(),
        ShareScreen.id: (Context) => ShareScreen(),
        ReportScreen.id: (Context) => ReportScreen(),
        DoctorScreen.id: (Context) => DoctorScreen(),
        AdminScreen.id: (Context) => AdminScreen(),
        WaitingScreen.id: (Context) => WaitingScreen(),
        ShareScreenDoc.id: (Context) => ShareScreenDoc(''),
        UserSupScreen.id: (Context) => UserSupScreen(),
        DocSupScreen.id: (Context) => DocSupScreen(),
        ResetScreen.id: (Context) => ResetScreen(),
        SelectDocScreen.id: (Context) => SelectDocScreen('','',''),
        AboutScreen.id: (Context) => AboutScreen()
      },
    );
  }
}