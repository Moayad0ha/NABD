import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:nabd/model/toast.dart';

import '../screens/admin_screen.dart';
import '../screens/doctor_screen.dart';
import '../screens/home_screen.dart';
import '../screens/waiting_screen.dart';

Future db_conn(email, pass) async {
  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  if (email == null || pass == null) {
    toast('All fields must be filled');
  } else {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword( email: email, password: pass);
      if (user != null) {
        print(user.user?.uid);
        var data = (await _firebase
            .collection('users')
            .doc(user.user?.uid)
            .get());
        Map<String, dynamic>? d = data.data();
        print(d);
        if(d!['type'] == 'user'){
          Get.to(() => HomeScreen(d));
        } else if (d['type'] == 'admin'){
          Get.to(() => AdminScreen());
        } else if(d['type'] == 'doctor'){
          if(d['approved'] == false){
            Get.to(() => WaitingScreen());
          }else if (d['approved'] == true){
            Get.to(() => DoctorScreen());
          }
        }
      }
    } catch (e) {
      if(e.toString() == '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.' || e.toString() == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.'){
        toast('Wrong email or password');
      }
      print(e);
    }
  }
}
