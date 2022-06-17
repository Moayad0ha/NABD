
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nabd/model/toast.dart';

import '../model/register_user.dart';
import 'login_screen.dart';


class EditUsers extends StatefulWidget {
  var data;
  EditUsers(this.data);
  static String id = 'edit_users';
  @override
  _EditUsersState createState() => _EditUsersState(data);
}

class _EditUsersState extends State<EditUsers>{
  var data;
  _EditUsersState(this.data);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _nationalIdController = TextEditingController();
  TextEditingController txt = TextEditingController();
  DateTime? _dateController;
  String? _bloodController;
  List<String> items = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  initState(){
    _nameController.text = data['name'];
    _nationalityController.text = data['nationality'];
    _nationalIdController.text = data['national_id'];
    txt.text = DateFormat.yMMMd().format(data['date_of_birth'].toDate());
    _bloodController = data['blood_type'];
  }

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
                Image.asset('images/supervisor.png',scale: 25,),
                SizedBox(width: 80,),
                Text('EDIT',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffE13C6C)),),
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
      body: SingleChildScrollView(
        child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
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
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,150,0,0),
                          child: Center(
                              child: Text(
                                'Edit user',
                                style: TextStyle(fontFamily: 'Londrina',color: Colors.white,fontSize: 24),
                              )
                          ),
                        ),
                        TextFormField(
                          controller: _nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Name',
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.transparent,
                            ),
                            hint: Text(
                              'Select Blood type',
                              style: TextStyle(color: Colors.white),
                            ),
                            items: items
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: _bloodController,
                            onChanged: (value) {
                              setState(() {
                                _bloodController = value as String;
                              });
                            },
                            buttonHeight: 45,
                            buttonWidth: size.width,
                            itemHeight: 40,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.grey,
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xfffe7fb7)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: _nationalityController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Nationality',
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
                          controller: _nationalIdController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'National ID',
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
                          controller: txt,
                          onTap: (){
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100)
                            ).then((date) {
                              setState(() {
                                _dateController = date;
                              });
                              txt.text = _dateController.toString();
                            });
                          },
                          keyboardType: TextInputType.none,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Date of birth',
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

                                    edit_user(
                                        name: _nameController.text,
                                        bloodtype: _bloodController,
                                        nationality: _nationalityController.text,
                                        nationalId: _nationalIdController.text,
                                        date: txt.text
                                    ).then(toast('update done'));


                                  },
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: Text(
                                    'Apply',
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

                      ]
                  )
              ),
            ]
        ),
      ),
    );
  }

  edit_user({name,bloodtype,nationality,nationalId,date}) async {
    final _firebase = FirebaseFirestore.instance;
    try {
      if(name != null){
        await _firebase.collection('users').doc(data.id).update({
          'name': name,
        });
      }
      if(date != null){
        await _firebase.collection('users').doc(data.id).update({
          'date_of_birth': date,
        });
      }
      if(nationalId != null){
        await _firebase.collection('users').doc(data.id).update({
          'national_id': nationalId,
        });
      }
      if(nationality != null){
        await _firebase.collection('users').doc(data.id).update({
          'nationality': nationality,
        });
      }
      if(bloodtype != null){
        await _firebase.collection('users').doc(data.id).update({
          'blood_type': bloodtype,
        });
      }
    } on Exception catch (e) {
      toast('error happend');
    }
  }

}