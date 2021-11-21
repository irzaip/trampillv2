import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_listtopic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trampillv2/api/class_materi.dart';

class DetailMateriScreen extends StatefulWidget {
  const DetailMateriScreen({Key? key}) : super(key: key);
  static const String routeName = '/detailmateri';

  @override
  State<DetailMateriScreen> createState() => _DetailMateriScreenState();
}

class _DetailMateriScreenState extends State<DetailMateriScreen> {
  TextStyle bigfont = const TextStyle(
      fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle titlefont = const TextStyle(
      fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle mediumfontbold = const TextStyle(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle mediumfont = const TextStyle(fontSize: 14, color: Colors.black);
  TextStyle kategorifont = TextStyle(fontSize: 13, color: Colors.blueGrey);
  TextStyle pengajar = const TextStyle(
      fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.w700);
  TextStyle hargafont = const TextStyle(
      fontSize: 20, color: Colors.redAccent, fontWeight: FontWeight.w700);
  TextStyle hargacoret = const TextStyle(
      fontSize: 20,
      color: Colors.redAccent,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.lineThrough);
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
    String api = '/api/listtopic/' + reqId.toString();
    String access = prefs.getString("access").toString();
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

  Widget infoMateri(materi) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Judul",
            style: titlefont,
          ),
          Text(materi.judul, style: bigfont),
          SizedBox(
            height: 8,
          ),
          Text("kategori", style: titlefont),
          Text(materi.kategori, style: mediumfont),
          SizedBox(
            height: 8,
          ),
          Text("info", style: titlefont),
          Text(
            materi.pendek,
            style: mediumfont,
          ),
          SizedBox(
            height: 8,
          ),
          Text("deskripsi", style: titlefont),
          Text(
            materi.deskripsi,
            style: mediumfont,
          ),
          SizedBox(
            height: 8,
          ),
          Text("Pengajar", style: titlefont),
          Text(
            materi.pengajar,
            style: mediumfont,
          ),
          SizedBox(
            height: 8,
          ),
          Text("Tags", style: titlefont),
          Text(
            materi.tags.toString(),
            style: mediumfont,
          ),
          SizedBox(height: 8,),
          Divider(),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Get.offNamed('/materi', arguments: materi);
              }, child: Text("Buka Materi")),
              IconButton(
                  color: Colors.blueAccent,
                  onPressed: () {},
                  icon: Icon(Icons.favorite)),
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Konten Materi", style: titlefont,),
            ],
          ),
          SizedBox(height: 10,),
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
        builder: (BuildContext context, AsyncSnapshot snapshot)  {
          if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return infoMateri(materi);
                  } else {
                    return Column(
                      children: [
                        Text(snapshot.data[index - 1].judul.toString()),
                        Divider(),
                      ],
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
