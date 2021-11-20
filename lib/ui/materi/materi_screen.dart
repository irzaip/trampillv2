import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trampillv2/api/class_topic.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trampillv2/api/class_materi.dart';

class MateriScreen extends StatefulWidget {
  MateriScreen({Key? key}) : super(key: key);
  static const routeName = '/materi';

  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  late Future<Object> resultmateri;
  late Materi materi;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    materi = Get.arguments;
    resultmateri = apiMainMateri(materi.id);
  }

  Future<List<Topic>> apiMainMateri(id) async {
    var prefs = await SharedPreferences.getInstance();
    final String api = '/api/topic/' + id.toString();
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      if (request.body == '{"status":"Belum terdaftar"}') {
        throw ("Anda harus mendaftar materi ini terlebih dahulu");
      }
      var result = compute(parseTopic, request.body);
      return result;
    } else if (request.statusCode == 401) {
      throw ("Error loading materi, not login?");
    } else {
      throw ("Errow Loading, belum terdaftar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(materi.judul),
      ),
      body: FutureBuilder(
          future: resultmateri,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return PageView.builder(
                  controller: _pageController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return Center(child: Text(snapshot.data[index].judul));
                  });
            } else if (snapshot.hasError &&
                snapshot.error.toString().contains('login')) {
              return Center(
                  child: Column(
                children: [
                  Text(snapshot.error.toString()),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: const Text("Login"))
                ],
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
              }, 
              child: Icon(Icons.arrow_left)),
            ElevatedButton(
              onPressed: null, 
              child: Icon(Icons.topic)),
            ElevatedButton(
              onPressed: () {
                _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
              }, 
              child: Icon(Icons.arrow_right)),

          ],
        ),
      ),
    );
  }
}
