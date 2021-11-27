import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> relogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString("username").toString();

  if (username == "null") {
    return false;
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
    return true;
  } else {
    return false;
  }
}

Future<bool> sendlogin(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mainhome = prefs.getString("mainhome").toString();
  var uri = Uri.parse(mainhome + '/api/token/');
  try {
    var request = http.MultipartRequest('POST', uri)
      ..fields['username'] = username
      ..fields['password'] = password;
    var response = await request.send().timeout(const Duration(seconds: 7));

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      Map<String, dynamic> parsed = json.decode(result.toString());
      prefs.setString("username", username);
      prefs.setString("password", password);
      prefs.setString("access", parsed['access'].toString());
      prefs.setString("refresh", parsed['refresh'].toString());
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw ("Error connection");
  }
}

Future<String> refreshToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mainhome = prefs.getString("mainhome").toString();
  var uri = Uri.parse(mainhome + '/api/token/refresh');

  //final uri = Uri.parse('https://neo.trampill.com/api/token/refresh/');

  Map data = {'refresh': token.toString()};
  var bod = jsonEncode(data);

  final response = await http.post(uri,
      headers: {"Content-Type": "application/json"}, body: bod);
  //print("token refresh "+ token);

  if (response.statusCode == 200) {
    Map<String, dynamic> parsed = jsonDecode(response.body.toString());
    return parsed['access'].toString();
  } else {
    return "error";
  }
}

/// fungsi register dengan berbagai int return,
/// * 0 - sukses.
/// * 1 - username sudah ada.
/// * 2 - password tidak sama.
/// * 3 - Email tidak valid
/// * 4 keatas - error tidak di ketahui.
Future<int?> register(
    String username, String email, String password, String confrimpass) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mainhome = prefs.getString("mainhome").toString();
  var uri = Uri.parse(mainhome + '/api/register/');

  // var uri = Uri.parse('https://neo.trampill.com/api/register/');

  var data = {
    'username': username.toString(),
    'password': password.toString(),
    'confirm_pass': confrimpass.toString(),
    'email': email.toString(),
  };
  var bod = jsonEncode(data);

  var response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: bod,
  );

  if (response.statusCode == 200 &&
      response.body.toString() ==
          r'{"username":["A user with that username already exists."]}') {
    //throw("Username sudah ada yang punya.");
    return 1;
  } else if (response.body.toString() == '{"error":"Password must match"}') {
    //throw("Password harus sama persis, kirim ulang lagi ya.");
    return 2;
  } else if (response.body.toString() ==
      '{"email":["Enter a valid email address."]}') {
    //throw("Email tidak valid")
    return 3;
  } else if (response.statusCode == 200) {
    //sukses
    return 0;
  } else {
    //error tidak di ketahui
    return 4;
  }
}
