import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_listtopic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:trampillv2/values/harga.dart';
import 'dart:convert';
import 'dart:io';

class DetailMateriScreen extends StatefulWidget {
  const DetailMateriScreen({Key? key}) : super(key: key);
  static const String routeName = '/detailmateri';

  @override
  State<DetailMateriScreen> createState() => _DetailMateriScreenState();
}

class _DetailMateriScreenState extends State<DetailMateriScreen> {
  late Materi materi;
  late Future<Object> resultMateri;
  late List<int> listterdaftar;
  var texttombol = 'Daftar Materi'.obs;
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    materi = Get.arguments;
    resultMateri = listtopic(materi.id);
    getListTerdaftar();
  }

  Future<void> getListTerdaftar() async {
    var prefs = await SharedPreferences.getInstance();
    var listtf = prefs.getString('listterdaftar');
    if (listtf != null) {
      listtf = listtf.replaceFirst('[', '').replaceFirst(']', '');
      listterdaftar = listtf.split(',').map((e) => int.parse(e)).toList();
      if (listterdaftar.contains(materi.id)) {
        texttombol = "Buka Materi".obs;
      }
    }
  }

  Future<String> mendaftarkan(materi) async {
    var prefs = await SharedPreferences.getInstance();
    String mainhome = prefs.getString("mainhome").toString();
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    var uri =
        Uri.parse(mainhome + '/api/mendaftar/' + materi.id.toString() + "/");
    var data = {
      'password': _password.text,
    };
    //var bod = jsonEncode(data);

    var response = await http.post(
      uri,
      headers: {
//        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: fulltoken
      },
      body: data,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['status'].toString();
      return result;
    }
    return "Terjadi kesalahan sewaktu mendaftar.";
  }

  Future<Object> listtopic(reqId) async {
    var prefs = await SharedPreferences.getInstance();
    String api = '/api/listtopic/' + reqId.toString();
    //String access = prefs.getString("access").toString();
    // String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(
      Uri.parse(mainhome + api),
      //headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var result = compute(parseListTopic, request.body);
      return result;
    } else {
      throw ("Error loading topic, login?");
    }
  }

  daftar(String instruksi) {
    if (instruksi.toString() == 'Daftar Materi') {
      AlertDialog alert = AlertDialog(
        title: const Text("Mendaftar"),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Perlu pembayaran untuk mengakses materi ini."),
              const Text("Lakukan pembayaran ke:"),
              const Text("rekening a/n: xx"),
              const Text("cabang: xxx"),
              const Text("no.rekening: 292989289"),
              materi.password
                  ? TextField(
                      controller: _password,
                    )
                  : const Text("no"),
            ]),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal")),
          ElevatedButton(
              onPressed: () async {
                var result = await mendaftarkan(materi);
                if (result == "Sukses, Materi telah di daftarkan") {
                  Navigator.of(context).pop();
                  // await Future.delayed(Duration(seconds: 1));

                  Get.snackbar(
                    "Status",
                    result,
                    icon: const Icon(Icons.person, color: Colors.white),
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
                  Get.offNamed('/materi', arguments: materi);
                } else {
                  Navigator.of(context).pop();
                  Get.snackbar(
                    "Status",
                    result,
                    icon: const Icon(Icons.person, color: Colors.white),
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
                }
              },
              child: const Text("OK")),
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    } else {
      Get.offNamed('/materi', arguments: materi);
    }
  }

  Widget infoMateri(materi) {
    var harga = materi.harga;
    var discount = materi.discount;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Judul",
            style: titlefont,
          ),
          Text(materi.judul, style: bigfont),
          const SizedBox(
            height: 8,
          ),
          const Text("kategori", style: titlefont),
          Text(materi.kategori, style: mediumfont),
          const SizedBox(
            height: 8,
          ),
          const Text("info", style: titlefont),
          Text(
            materi.pendek,
            style: mediumfont,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text("deskripsi", style: titlefont),
          Text(
            materi.deskripsi,
            style: mediumfont,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text("Pengajar", style: titlefont),
          Text(
            materi.pengajar,
            style: mediumfont,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text("Tags", style: titlefont),
          Text(
            materi.tags.toString(),
            style: mediumfont,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Akses Menggunakan Password:",
            style: titlefont,
          ),
          Text(materi.password ? "YA" : "TIDAK"),
          const SizedBox(
            height: 8,
          ),
          const Text("Harga", style: titlefont),
          Row(
            children: [
              Text(
                hitungharga(harga, discount),
                style: fontharga(harga, discount),
              ),
              Text(
                hitungdiscount(harga, discount),
                style: hargafont,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // ignore: unnecessary_brace_in_string_interps
                    daftar("${texttombol}");

                    //Get.offNamed('/materi', arguments: materi);
                  },
                  // ignore: unnecessary_brace_in_string_interps
                  child: Obx(() => Text("${texttombol}"))),
              IconButton(
                  color: Colors.blueAccent,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Konten Materi",
                style: titlefont,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]));
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
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return infoMateri(materi);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index - 1].judul.toString(),
                            style: mediumfont,
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  }
                });
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
        },
      ),
    );
  }
}
