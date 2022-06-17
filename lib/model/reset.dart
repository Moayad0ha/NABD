


import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabd/model/toast.dart';

reset(email) async{

  final _auth = FirebaseAuth.instance;
  await _auth.sendPasswordResetEmail(email: email).then((value) => toast('a recovery email is sent'));
} 