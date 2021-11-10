import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_pembayaran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:trampillv2/api/login_provider.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({Key? key}) : super(key: key);

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  @override
  void initState() {
    //super.initState();
    print("INITSTATE PEMBAYARAN");
  }

  Future<Object> pembayaran() async {
    var prefs = await SharedPreferences.getInstance();
    const String api = '/api/pembayaran';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();
    print("Mainhome:" + mainhome);

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      var result = compute(parseListPembayaran, request.body);
      return result;
    } else {
      throw ("Error loading favorit, login?");
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
            future: pembayaran(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return Text(snapshot.data[index].no_order.toString());
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(children: [
                    SizedBox(height: 150),
                    Text("Error loading. login First"),
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
