import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_pendaftaran.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:get/get.dart';
import 'package:trampillv2/values/fontstyle.dart';

class MateriSayaScreen extends StatefulWidget {
  const MateriSayaScreen({Key? key}) : super(key: key);
  static const String routeName = '/materisaya';

  @override
  State<MateriSayaScreen> createState() => _MateriSayaScreenState();
}

class _MateriSayaScreenState extends State<MateriSayaScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late var loggedin;
  var listterdaftar = [];


  // @override
  // void initState() {
  //   // super.initState();
  //   loggedin = relogin();
  // }

  Future<String> hapusPendaftaran(materi) async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/hapuspendaftaran/' + materi.toString() + "/";
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
        var response = jsonDecode(request.body).toString();
        return response;
    } else {
        throw ("Error menghapus materi");
    }

  }

  Future<Object> pendaftaran() async {
    var prefs = await SharedPreferences.getInstance();
    const String api = '/api/pendaftaran';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      var result = await compute(parseListPendaftaran, request.body);
      // ignore: avoid_function_literals_in_foreach_calls
      result.forEach((element) { listterdaftar.add(element.materi.id);});
      // listterdaftar.sort();
      prefs.setString('listterdaftar', listterdaftar.toString());
      return result;
    } else {
      throw ("Error loading pendaftaran, login?");
    }
  }

  Widget materiCard(materi) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Text(materi.judul, style: bigfont,)),
            IconButton(
              color: Colors.blue,
              onPressed: () {}, icon: const Icon(Icons.favorite)),
            ElevatedButton(onPressed: () {
              Get.toNamed('/materi', arguments: materi);
            }, child: const Text("Buka")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { 
          Get.offAllNamed('/');
        }, icon: const Icon(Icons.arrow_left_outlined)),
        title: const Text("Materi terdaftar saya"),
      actions: [
        IconButton(
          tooltip: "Favorit",
          onPressed: () {
          Get.toNamed('/favorit');
        }, 
        icon: const Icon(Icons.favorite),),
      ],
      ),
      body: FutureBuilder(
          future: pendaftaran(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      background: Container(color: Colors.red,),
                      key: Key(snapshot.data[index].toString()),
                      onDismissed: (direction) async {
                        snapshot.data.removeAt(index);
                        // listterdaftar.removeAt(index);
                        var response = await hapusPendaftaran(listterdaftar[index]);
                        Get.offAndToNamed("/materisaya");
                        Get.snackbar(
                          "STATUS",
                          response,
                          icon: const Icon(Icons.info, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          borderRadius: 20,
                          margin: const EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 4),
                          isDismissible: true,
                          dismissDirection: SnackDismissDirection.HORIZONTAL,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );
                      },
                      child: materiCard(
                        snapshot.data[index].materi),
                    );   });  
            } else if (snapshot.hasError) {
              return Center(
                child: Column(children: [
                  const SizedBox(height: 150),
                  const Text("Error loading. login First"),
                  ElevatedButton(
                    onPressed: () async {
                      var result = await Get.toNamed('/login');
                      if (result == "success") {
                        setState(() {});
                      }
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
