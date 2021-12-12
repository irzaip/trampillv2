  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;
  import 'package:flutter/foundation.dart';
  import 'package:trampillv2/api/class_message.dart';
  import 'dart:io';


  /// Mengambil list/daftar message di url /api/message
  Future<List<Message>> getMessages() async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/message/';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(
      Uri.parse(mainhome + api),
      headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var result = compute(parseMessage, request.body);
      return result;
    } else {
      throw ("Error loading Message, login?");
    }
  }

  Future<int> messageCount() async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/message/';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(
      Uri.parse(mainhome + api),
      headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var result = await compute(parseMessage, request.body);
      // print(result.length);
      return result.length.toInt();
    } else {
      return 0;
    }
  }