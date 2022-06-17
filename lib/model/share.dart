import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabd/model/toast.dart';

Future<void> shareData(rep_id, doc_id,user_id,user_name) async {
  print('hi');
  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;
  final uid = user?.uid;

  var today = new DateTime.now();
  var two_days = today.add(new Duration(hours: 48));
  try {
    await _firebase.collection('users').doc(doc_id).collection('reports').add({
      'source': rep_id,
      'user_id':user_id,
      'permission_period': two_days,
      'user_name':user_name
    }).then((value) async => await _firebase
            .collection('users')
            .doc(uid)
            .collection('reports')
            .doc(rep_id)
            .update({
          'share': true,
        }).then((value) => toast('report shared')));
  } on Exception catch (e) {
    print(e);
    toast('error has occured');
  }
}
