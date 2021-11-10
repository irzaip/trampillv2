import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:trampillv2/api/httpapi.dart';
//import 'class_materi.dart';
import 'class_pendaftaran.dart';

Future<void> apiPendaftaran(context) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString("username").toString();

  if (username == "null") {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
        //Navigator.pushReplacementNamed(context,"/login");
        Navigator.pushNamed(context, "/login");
        });
  }

  String password = prefs.getString("password").toString();
  String mainhome = prefs.getString("mainhome").toString();
  var uri = Uri.parse(mainhome + '/api/token/');

  var request = http.MultipartRequest('POST', uri)
  ..fields['username'] = username
  ..fields['password'] = password;
  var response = await request.send().timeout(const Duration(seconds: 15));

  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    Map<String, dynamic> parsed = json.decode(result.toString());
    prefs.setString("username", username);
    prefs.setString("password", password);
    prefs.setString("access", parsed['access'].toString());
    prefs.setString("refresh", parsed['refresh'].toString());
  
    const String api = '/api/pendaftaran';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer '+ access; 
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api), headers: {HttpHeaders.authorizationHeader : fulltoken});

    if (request.statusCode == 200) {
    
    return;
    } else {
      // throw Exception('Failed to load Pendaftaran');
      Navigator.pushNamed(context, "/login");
      return;
    }  
  } else {
    //throw Exception('Token Expired or Failed Login');
    // Navigator.pushReplacementNamed(context, "/login");
    Navigator.pushNamed(context, "/login");
    return;
  }
}


// A function that converts a response body into a List<ListMateri>.
// List<Pendaftaran> parsePendaftaran(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Pendaftaran>((json) => Pendaftaran.fromJson(json)).toList();
// }

Pendaftaran parsePendaftaran(String responseBody) {
  final parsed = json.decode(responseBody);
  return Pendaftaran.fromJson(parsed);
}
