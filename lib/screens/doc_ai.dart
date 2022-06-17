import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'dart:io';
import 'package:http/http.dart' as http;



dynamic authorizationEndpoint = '';
dynamic tokenEndpoint = '';
var identifier = '';
final credentialsFile = File('~/.myapp/credentials.json');
var redirectUrl = 'com.googleusercontent.apps.948829121301-cv83daf521580671csiijpfareeo62dd:/oauth2redirect';

Future<void> readJson() async {

  final String response = await rootBundle.loadString('assets/client.json');
  final data = await json.decode(response);
  authorizationEndpoint = data['installed']['auth_uri'];
  print(authorizationEndpoint);
  tokenEndpoint = data['installed']['token_uri'];
  print(tokenEndpoint);
  identifier = data['installed']['client_id'];
  print(identifier);
  getToken();
  // fetchFiles();
}
Future<void> getToken() async {
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
  var _accessToken = result?.accessToken;

  var body = '{"payload": {"document": {"input_config": {"gcs_source": {"input_uris": "gs://my-nabd-reports/reports_train/anti-nuclear-antibody-letterhead-with-sign-1.pdf"}}}}}';


  final http.Response httpResponse = await http.post(
      Uri.parse('https://automl.googleapis.com/v1/projects/948829121301/locations/us-central1/models/TEN230666544391127040:predict'),
      headers: <String, String>{'Authorization': 'Bearer $_accessToken'},body: body);
  print(httpResponse.body);

}

// Future<void> _testApi(TokenResponse? response) async {
//   final http.Response httpResponse = await http.get(
//       Uri.parse('https://demo.identityserver.io/api/test'),
//       headers: <String, String>{'Authorization': 'Bearer $_accessToken'});
//       print(httpResponse.statusCode);
// }


class Doc_ai extends StatefulWidget {

  static String id = 'doc_ai';

  @override
  _Doc_aiState createState() => _Doc_aiState();
}

class _Doc_aiState extends State<Doc_ai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text('test'),
            onPressed: (){
              readJson();
            },
          ),
        ),
      ),
    );
  }
}
