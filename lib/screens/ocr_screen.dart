import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';
import 'package:path/path.dart' as path;
// import 'package:mime/mime.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:random_string/random_string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/toast.dart';
import 'read_json.dart';
import 'home_screen.dart';


class OcrScreen extends StatefulWidget {
  static String id = 'ocr_screen';
  @override
  _OcrScreenState createState() => _OcrScreenState();

}

class _OcrScreenState extends State<OcrScreen>{


  @override
  Widget build(BuildContext context) {
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
                Image.asset('images/appbar1.png',scale: 0.8,),
                SizedBox(width: 80,),
                Text('OCR',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffE13C6C)),),
                SizedBox(width: 70,),
                Image.asset('images/appbar2.png',scale: 1.1,),
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
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.white,
                      shadowColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: (){
                          pickImage('cam');
                        },
                        minWidth: 150.0,
                        height: 42.0,
                        child: Text(
                          'capture',
                          style: TextStyle(fontFamily:'Londrina',color: Color(0xffe13c6c),fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.white,
                      shadowColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: (){
                          pickImage('up');
                          // Check_db();
                        },
                        minWidth: 150.0,
                        height: 42.0,
                        child: Text(
                          'upload',
                          style: TextStyle(fontFamily:'Londrina',color: Color(0xffe13c6c),fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Color(0xffF975AB),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SettingScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white,),
                          Text('settings',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ShareScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share,color: Colors.white,),
                          Text('share', style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, OcrScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.report, color: Colors.white,),
                          Text('ocr',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home,color: Colors.white,),
                          Text('home',style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ],
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

  final picker = ImagePicker();
  late dynamic _imageFile;
  final pdf = pw.Document();
  late File file;
  dynamic pickedFile;
  var link;
  FirebaseStorage storage = FirebaseStorage.instance;
  var filenamer;

  Future pickImage(method) async {
    if(method == 'cam'){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
      _imageFile = File(pickedFile!.path);
      filenamer = randomAlphaNumeric(10).toString();
      createPDF();
    }else if(method == 'up'){
      filenamer = randomAlphaNumeric(10).toString();
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'tiff', 'tif'],
      );
      if (pickedFile == null) {
        toast('no file is selected');
      }else{
      String str = (pickedFile?.paths[0]).toString();
      _imageFile = File(str);
      print("the is: $_imageFile");
      if(_imageFile.path.endsWith('jpg') || _imageFile.path.endsWith('png') || _imageFile.path.endsWith('tif') || _imageFile.path.endsWith('tiff')) {
        createPDF();
      }else if(_imageFile.path.endsWith('pdf')){
        String dir = (await getApplicationDocumentsDirectory()).path;
        String newPath = path.join(dir, '$filenamer.pdf');
        file = await File(_imageFile.path).copy(newPath);
        print('theeeee is ${file.path}');
        print(_imageFile.path);
        uploadImageToFirebase(context);
      }
      }
    }

    setState(() {

    });
  }

  createPDF() async {
      final image = pw.MemoryImage(_imageFile.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
      savePDF();
  }

  savePDF() async {
    try {
      file = File('/data/user/0/com.example.nabd/cache/$filenamer.pdf');
      await file.writeAsBytes(await pdf.save());
      print(file);
      print('success saved to documents');
      uploadImageToFirebase(context);
    } catch (e) {
      print('error ${e.toString()}');
    }
  }


  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = path.basename(file.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => link = value,
      //print("Done: $value"),
    ).then((value) => readJson(link,filenamer));

  }

}
