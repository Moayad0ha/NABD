import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/model/toast.dart';

import '../screens/login_screen.dart';

Future regs_user(name, pass, blood, nation, nation_id, email, date) async {
  if (name == null ||
      pass == null ||
      blood == null ||
      nation == null ||
      nation_id == null ||
      email == null ||
      date == null) {
    toast('All fields must be filled');
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
            'nationality': nation,
            'national_id': nation_id,
            'blood_type': blood,
            'date_of_birth': date,
            'email': email,
            'type': 'user'
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
