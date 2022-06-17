import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/model/toast.dart';
import 'package:nabd/screens/login_screen.dart';

Future regs_doc(name, pass, email, cert, special, job_title) async {
  if (name == null ||
      pass == null ||
      cert == null ||
      special == null ||
      email == null ||
      job_title == null) {
    toast('All field must be filled');
  } else {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      toast('Enter a valid email');
    } else {
      final _firebase = FirebaseFirestore.instance;
      final _auth = FirebaseAuth.instance;
      bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        toast('Enter a valid email');
      } else {
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: pass);
          if (newUser != null) {
            print(newUser.user?.uid);
            await _firebase.collection('users').doc(newUser.user?.uid).set({
              'name': name,
              'certifcation': cert,
              'speciality': special,
              'job title': job_title,
              'approved': false,
              'email': email,
              'type': 'doctor'
            }).then((value) {
              toast('account created');
              Get.to(LoginScreen());
            },);
          }
        } catch (e) {
          if (e.toString() ==
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
            toast('This email is already found');
          } else if (e.toString() ==
              '[firebase_auth/weak-password] Password should be at least 6 characters') {
            toast('Password should be at least 6 characters');
          }
          print(e);
        }
      }
    }
  }
}

