import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/toast.dart';



dynamic authorizationEndpoint = '';
dynamic tokenEndpoint = '';
var identifier = '';
final credentialsFile = File('~/.myapp/credentials.json');
var redirectUrl = 'com.googleusercontent.apps.948829121301-cv83daf521580671csiijpfareeo62dd:/oauth2redirect';
var source;
var date;
var lab_name;
Map test_name = {};
Map test_result = {};


final _firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;



Future<void> readJson(String link, String filename) async {

  final String response = await rootBundle.loadString('assets/client.json');
  final data = await json.decode(response);
  authorizationEndpoint = data['installed']['auth_uri'];
  print(authorizationEndpoint);
  tokenEndpoint = data['installed']['token_uri'];
  print(tokenEndpoint);
  identifier = data['installed']['client_id'];
  print(identifier);
  getToken(link,filename);
}
Future<void> getToken(String link, String filename) async {
  final user = _auth.currentUser;
  final uid = user?.uid;
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? refresh_token = prefs.getString('refresh_token');
  if(token == null || refresh_token == null){
    FlutterAppAuth appAuth = FlutterAppAuth();
    final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        identifier,
        redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(authorizationEndpoint: authorizationEndpoint,  tokenEndpoint: tokenEndpoint),
        scopes: ['https://www.googleapis.com/auth/cloud-platform'],
      ),
    );
    print(result?.accessToken);
    print(result?.refreshToken);
    String? _accessToken = result?.accessToken;
    String? _refreshtoken = result?.refreshToken;
    await prefs.setString('token', _accessToken.toString());
    await prefs.setString('refresh_token', _refreshtoken.toString());
  }


    Future<void> refresh() async {
      FlutterAppAuth appAuth = FlutterAppAuth();
      try {
        print(token);
        print(refresh_token);
        final TokenResponse? result = await appAuth.token(TokenRequest(
            identifier, redirectUrl,
            refreshToken: refresh_token,
            serviceConfiguration: AuthorizationServiceConfiguration(
                authorizationEndpoint: authorizationEndpoint,
                tokenEndpoint: tokenEndpoint),
            scopes: ['https://www.googleapis.com/auth/cloud-platform']));
        print(result?.accessToken);
        await prefs.setString('token', (result?.accessToken).toString());
        getToken(link, filename);
      } catch (e) {
        print(e);
      }
    }


    var body =
        '{"payload": {"document": {"input_config": {"gcs_source": {"input_uris": "gs://nabd-8452d.appspot.com/uploads/$filename.pdf"}}}}}';

    final http.Response httpResponse = await http.post(
        Uri.parse(
            'https://automl.googleapis.com/v1/projects/948829121301/locations/us-central1/models/TEN230666544391127040:predict'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
        body: body);
    if (httpResponse.statusCode == 200) {
      print('here200');
      source = link;
      var response_body = jsonDecode(httpResponse.body);
      int i = 0;
      int j = 0;
      for (var index in response_body['payload']){
        print(index);
        if(index['displayName'] == 'lab_date_value'){
          date = index['textExtraction']['textSegment']['content'];
        }
        if(index['displayName'] == 'lab_name_value'){
          lab_name = index['textExtraction']['textSegment']['content'];
        }
        if(index['displayName'] == 'test_name'){
          test_name['key$i'] = index['textExtraction']['textSegment']['content'];
          i++;
        }
        if(index['displayName'] == 'test_result'){
          test_result['key$j'] = index['textExtraction']['textSegment']['content'];
          j++;
        }
      }
      print(test_name);
      await _firebase.collection('users').doc(uid).collection('reports').add({
        'source': source,
        'date': date,
        'lab_name': lab_name,
        'test_name': test_name,
        'test_result': test_result,
        'share': false
      }).then((value) {
        toast('report uploaded');
      },);
    } else if (httpResponse.statusCode == 401) {
      refresh();
    }
    print(httpResponse.statusCode);

}



