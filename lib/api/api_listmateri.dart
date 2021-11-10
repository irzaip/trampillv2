//import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class_materi.dart';
import 'dart:convert';

Future<List<Materi>> apiListMateri(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mainhome = prefs.getString("mainhome").toString();
  //prefs.setString("username", "teststudent");
  //prefs.setString("password", "test1001");
  if (mainhome == "null") {
    await prefs.setString("mainhome", "https://neo.trampill.com");
    mainhome = "https://neo.trampill.com";
  }

  const String api = '/api/listmateri';
  // String access = prefs.getString("access").toString();
  // String fulltoken = 'Bearer '+ access; 

  final request = await http.get(Uri.parse(mainhome + api));
  //, headers: {HttpHeaders.authorizationHeader : fulltoken});
  if (request.statusCode == 200) {
    return compute(parseListMateri, request.body);
  // } else if (request.statusCode == 401) {
  //   throw Exception('Token Expired or Failed Login');
  } else {
    throw Exception('Failed to load List Materi');
  }  
}

// A function that converts a response body into a List<Materi>.
List<Materi> parseListMateri(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Materi>((json) => Materi.fromJson(json)).toList();
}