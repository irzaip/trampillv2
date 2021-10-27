import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void initpref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mainhome = prefs.getString("mainhome").toString();
  if (mainhome == "null") {
    prefs.setString("mainhome", "https://neo.trampill.com");
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
  } catch (e) { throw("Error connection");}
}




Future<String> refreshToken(token) async {
  final uri = Uri.parse('https://neo.trampill.com/api/token/refresh/');

  Map data = {
    'refresh': token.toString()
  };
  var bod = jsonEncode(data);

  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"}, 
    body: bod);
   //print("token refresh "+ token);

   if (response.statusCode == 200) {
     Map<String, dynamic> parsed = jsonDecode(response.body.toString());
     return parsed['access'].toString();

   } else {

     return "error";
   }
}
