import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_listtopic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:trampillv2/api/class_materi.dart';

class DetailMateriScreen extends StatefulWidget {
  const DetailMateriScreen({Key? key}) : super(key: key);
  static const String routeName = '/detailmateri';

  @override
  State<DetailMateriScreen> createState() => _DetailMateriScreenState();
}


class _DetailMateriScreenState extends State<DetailMateriScreen> {
late Materi materi;
late Future<Object> resultMateri;

@override
void initState() {
  super.initState();
  materi = Get.arguments;  
  resultMateri = listtopic(materi.id);
}
  Future<Object> listtopic(reqId) async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/topic/' + reqId.toString();
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      var result = compute(parseListTopic, request.body);
      return result;
    } else {
      throw ("Error loading topic, login?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRAMPILL"),
      ),
      body: FutureBuilder(
        future: resultMateri,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return Text(snapshot.data[index].judul.toString());
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
        },
      ),
    );
  }
}
