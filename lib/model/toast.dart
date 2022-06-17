

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 16.0
  );
}