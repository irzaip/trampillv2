  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:trampillv2/api/class_kegiatan.dart';
  import 'package:trampillv2/api/class_listkegiatan.dart';
  import 'package:http/http.dart' as http;
  import 'package:flutter/foundation.dart';


  /// Mengambil list/daftar kegiatan di url /api/listkegiatan
  Future<List<Kegiatan>> getListKegiatan() async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/listkegiatan/';
    // String access = prefs.getString("access").toString();
    // String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(
      Uri.parse(mainhome + api),
      //headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var result = compute(parseListKegiatan, request.body);
      return result;
    } else {
      throw ("Error loading kegiatan, login?");
    }
  }

  /// Mengambil data kegiatan di url /api/kegiatan/<int>
  Future<Kegiatan> getKegiatan(reqId) async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/kegiatan/' + reqId.toString();
    // String access = prefs.getString("access").toString();
    // String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        // headers: {HttpHeaders.authorizationHeader: fulltoken}
        );

    if (request.statusCode == 200) {
      var result = compute(parseKegiatan, request.body);
      return result;
    } else {
      throw ("Error loading kegiatan, login?");
    }
  }
