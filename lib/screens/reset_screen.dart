
import 'package:flutter/material.dart';
import 'package:nabd/model/reset.dart';



class ResetScreen extends StatefulWidget {
  static String id = 'reset_screen';
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen>{
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:Text('reset password',style: TextStyle(fontSize: 30,fontFamily: 'Londrina',color: Color(0xffffffff)),),),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,150.0,0,50),
                        child: Center(
                            child: Text(
                              'Enter your email',
                              style: TextStyle(fontFamily: 'Londrina',color: Colors.white,fontSize: 24),
                            )
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'email',
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
                                  reset(_nameController.text);
                                },
                                minWidth: 200.0,
                                height: 42.0,
                                child: Text(
                                  'Send',
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
            Positioned(
              top: -80,
              right: -60,
              child: Hero(
                tag: 'logo',
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
            ),
          ],
        ),
      ),
    );
  }


}