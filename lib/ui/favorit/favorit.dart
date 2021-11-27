import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_favorit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:get/get.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {


  Future<Object> favorit() async {
    var prefs = await SharedPreferences.getInstance();
    const String api = '/api/favorit';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      var result = compute(parseListFavorit, request.body);
      return result;
    } else {
      throw ("Error loading favorit, login?");
    }
  }

  Widget favCard(materi) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(materi.judul),
        leading: const Icon(Icons.arrow_forward),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(Icons.arrow_left)),
        title: const Text("Favorit"),
      ),
      body: FutureBuilder(
            future: favorit(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return favCard(snapshot.data[index].materi);
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(children: [
                    const SizedBox(height: 150),
                    const Text("Error loading. login First"),
                    ElevatedButton(
                      onPressed: () async {
                        await Get.to('/login');
                        setState(() {});
                      },
                      child: const Text("Login"),
                    )
                  ]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
      }),
    );
  }
}
