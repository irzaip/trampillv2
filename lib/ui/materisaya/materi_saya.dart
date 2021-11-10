import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_pendaftaran.dart';
import 'package:trampillv2/api/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:io';

class MateriSayaScreen extends StatefulWidget {
  const MateriSayaScreen({Key? key}) : super(key: key);
  static const String routeName = '/materisaya';

  @override
  State<MateriSayaScreen> createState() => _MateriSayaScreenState();
}

class _MateriSayaScreenState extends State<MateriSayaScreen> {
  late var loggedin;

  // @override
  // void initState() {
  //   // super.initState();
  //   loggedin = relogin();
  // }

  Future<Object> pendaftaran() async {
    var prefs = await SharedPreferences.getInstance();
    const String api = '/api/pendaftaran';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      var result = compute(parseListPendaftaran, request.body);
      return result;
    } else {
      throw ("Error loading pendaftaran, login?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
      ),
      body: Consumer<LoginState>(builder: (context, login, _) {
        return FutureBuilder(
            future: pendaftaran(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return Text(snapshot.data[index].materi.judul.toString());
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(children: [
                    const SizedBox(height: 150),
                    const Text("Error loading. login First"),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/login');
                        setState(() {});
                      },
                      child: const Text("Login"),
                    )
                  ]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      }),
    );
  }
}
