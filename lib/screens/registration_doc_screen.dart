import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../model/register_doc.dart';
import 'login_screen.dart';


class RegistrationDocScreen extends StatefulWidget {
  static String id = 'registration_doc_screen';
  @override
  _RegistrationDocScreenState createState() => _RegistrationDocScreenState();
}

class _RegistrationDocScreenState extends State<RegistrationDocScreen>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  String? _certController;
  String? _jobTitleController;
  List<String> items = [
    'General Practitioner',
    'Resident Doctor',
    'Specialist',
    'Consultant'
  ];



  final picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
      uploadImageToFirebase(context);
    });
  }

  late File _imageFile;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = path.basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => _certController = value,
      //print("Done: $value"),
    );

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:Text('Sign up',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffffffff)),),),
      body: SingleChildScrollView(
        child: Stack(
            children: <Widget>[
              Container(
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
                                'Create an account',
                                style: TextStyle(fontFamily: 'Londrina',color: Colors.white,fontSize: 24),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset('images/adduser.png',),
                        ),
                        TextField(
                          controller: _nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'name',
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
                          controller: _emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
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
                          controller: _passController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'password',
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
                              'Select job title',
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
                            value: _jobTitleController,
                            onChanged: (value) {
                              setState(() {
                                _jobTitleController = value as String;
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
                          controller: _specializationController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter your specialization',
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            elevation: 0,
                            color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.white)
                              ),
                            child: MaterialButton(
                              onPressed: (){
                                pickImage();
                              },
                              minWidth: size.width,
                              height: 42.0,
                              child: Text(
                                'upload certifaction',
                                style: TextStyle(fontFamily:'Londrina',color: Colors.white,fontSize: 20),
                              ),
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

                                    regs_doc(
                                        _nameController.text,
                                        _passController.text,
                                        _emailController.text,
                                        _certController,
                                        _specializationController.text,
                                        _jobTitleController
                                    );


                                  },
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: Text(
                                    'Sign up',
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,200),
                          child: Center(
                            child: RichText(
                                text: TextSpan(
                                  text: 'already have an account?',
                                  style: TextStyle(
                                      fontFamily:'Londrina',
                                      fontSize:18,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(context, LoginScreen.id),
                                )
                            ),
                          ),
                        )

                      ]
                  )
              ),
              Positioned(
                top: -80,
                right: -60,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('images/appbar2.png',alignment: Alignment(-0.3,0.5),),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(190),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

}