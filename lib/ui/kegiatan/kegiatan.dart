import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';

class KegiatanScreen extends StatefulWidget {
  KegiatanScreen({Key? key}) : super(key: key);
  static const routeName = '/kegiatan';

  @override
  _KegiatanScreenState createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  TextStyle bigfont = const TextStyle(
      fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle mediumfont = const TextStyle(fontSize: 18, color: Colors.black);
  TextStyle linkfont = const TextStyle(fontSize: 16, color: Colors.blueGrey);
  TextStyle kategorifont = const TextStyle(fontSize: 13, color: Colors.blueGrey);
  late Future<Kegiatan> kegiatan;

@override
void initState() {
  super.initState();
  kegiatan = getKegiatan(1);
}


  Future<Kegiatan> getKegiatan(reqId) async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/kegiatan/' + reqId.toString();
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(
      Uri.parse(mainhome + api),
      headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var result = compute(parseKegiatan, request.body);
      return result;
    } else {
      throw ("Error loading kegiatan, login?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trampill"),
      ),
      body: FutureBuilder(
        future: kegiatan,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data.judulAcara),
              ],
            );

          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }

        },)
      ,);
  }
}