import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nabd/screens/report_screen.dart';
import 'package:nabd/screens/select_doc_screen.dart';
import 'package:nabd/screens/setting_screen.dart';
import 'package:nabd/screens/share_screen.dart';

import 'home_screen.dart';
import 'ocr_screen.dart';

class ReportView extends StatefulWidget {
  var data;
  var user_id;
  var user_name;
  ReportView(this.data, this.user_id,this.user_name);

  @override
  _ReportViewState createState() => _ReportViewState(data, user_id,user_name);
}

class _ReportViewState extends State<ReportView> {
  var data;
  var user_id;
  var user_name;
  _ReportViewState(this.data, this.user_id,this.user_name);

  prnt(data) {
    var dat = jsonDecode(data);
    print('********************************************************');
    // try {
    //   print(data['lab_name']);
    // } on Exception catch (e) {
    //  print(e);
    // }
    print('********************************************************');
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
                Image.asset(
                  'images/appbar1.png',
                  scale: 0.8,
                ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  'Report',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Londrina',
                      color: Color(0xffE13C6C)),
                ),
                SizedBox(
                  width: 70,
                ),
                Image.asset(
                  'images/appbar2.png',
                  scale: 1.3,
                ),
              ]),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
      ),
      body: Stack(alignment: Alignment.center,children: [Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                  child: Expanded(
                      child: Text(
                    (() {
                      if (data.data()['lab_name'] == null) {
                        return "lab_name";
                      } else {
                        return data.data()['lab_name'];
                      }
                    })(),
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Londrina',
                        color: Color(0xffffffff)),
                  )),
                ),
                DataTable(
                  columnSpacing: size.width * 0.4,
                  columns: [
                    DataColumn(
                        label: Text('test',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Londrina',
                                color: Color(0xffffffff)))),
                    DataColumn(
                        label: Text('result',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Londrina',
                                color: Color(0xffffffff))))
                  ],
                  rows: [
                    if (data.data()['test_result'] == null &&
                        data.data()['test_name'] == null) ...[
                      DataRow(cells: [
                        DataCell(Text('No data available',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Londrina',
                                color: Color(0xffffffff)))),
                        DataCell(SizedBox.shrink()),
                      ])
                    ] else ...[
                      if (data.data()['test_result'].length >=
                          data.data()['test_name'].length) ...[
                        for (var i = 0;
                            i < data.data()['test_result'].length;
                            i++) ...[
                          DataRow(cells: [
                            if (data.data()['test_name']['key$i'] == null) ...[
                              DataCell(Text('---',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Londrina',
                                      color: Color(0xffffffff))))
                            ] else ...[
                              DataCell(Text(data.data()['test_name']['key$i'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Londrina',
                                      color: Color(0xffffffff))))
                            ],
                            DataCell(Text(data['test_result']['key$i'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Londrina',
                                    color: Color(0xffffffff))))
                          ])
                        ]
                      ] else if (data.data()['test_result'].length <
                          data.data()['test_name'].length) ...[
                        for (var i = 0;
                            i < data.data()['test_name'].length;
                            i++) ...[
                          DataRow(cells: [
                            DataCell(Text(data.data()['test_name']['key$i'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Londrina',
                                    color: Color(0xffffffff)))),
                            if (data.data()['test_result']['key$i'] ==
                                null) ...[
                              DataCell(Text('---',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Londrina',
                                      color: Color(0xffffffff))))
                            ] else ...[
                              DataCell(Text(data.data()['test_result']['key$i'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Londrina',
                                      color: Color(0xffffffff))))
                            ]
                          ])
                        ]
                      ]
                    ],
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    shadowColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        print('*********************************');
                        print(data.id);
                        Get.to(() => SelectDocScreen(data.id, user_id,user_name));
                      },
                      minWidth: 150.0,
                      height: 20.0,
                      child: Text(
                        'share',
                        style: TextStyle(
                            fontFamily: 'Londrina',
                            color: Color(0xffe13c6c),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
            ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(
                0.0, 0.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[Color(0xfffe7fb7), Color(0xffe13c6c)],
          ),),
        ),
        Positioned(
          bottom: 0,
          child: Container(
              width: size.width,
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
                    onTap: () {
                      Navigator.pushNamed(context, SettingScreen.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        Text(
                          'settings',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ShareScreen.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Text(
                          'share',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OcrScreen.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report,
                          color: Colors.white,
                        ),
                        Text(
                          'ocr',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      int i = 0;
                      Navigator.of(context).popUntil((route) {
                        return i++ == 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        Text(
                          'home',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ]
      ),
    );
  }
}
