import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:flutter/foundation.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trampillv2/api/api_listkegiatan.dart';
import 'package:get/get.dart';

class KegiatanScreen extends StatefulWidget {
  KegiatanScreen({Key? key}) : super(key: key);
  static const routeName = '/kegiatan';

  @override
  _KegiatanScreenState createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  late Future<Kegiatan> kegiatan;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    kegiatan = getKegiatan(arguments.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kegiatan"),
        actions: [
          IconButton(onPressed: () {
            Get.offNamed('/listkegiatan');
          }, icon: Icon(Icons.list))
        ],
      ),
      body: FutureBuilder(
        future: kegiatan,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return detailKegiatan(snapshot);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container detailKegiatan(AsyncSnapshot<dynamic> snapshot) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kegiatan :",
              style: bigfont,
            ),
            Text(
              snapshot.data.judulAcara,
              style: titlefont,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Status :",
              style: bigfont,
            ),
            Text(snapshot.data.statusAcara, style: mediumfont),
            SizedBox(
              height: 10,
            ),
            Text(
              "Judul Materi :",
              style: bigfont,
            ),
            Text(
              snapshot.data.judulMateri,
              style: mediumfont,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Deskripsi :", style: bigfont),
            Text(
              snapshot.data.deskripsi,
              style: mediumfont,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rating :",
              style: bigfont,
            ),
            Text(
              snapshot.data.rating.toString(),
              style: mediumfont,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Tanggal Mulai :", style: bigfont),
            Text(toDate(snapshot.data.tanggalMulai)),
            SizedBox(height: 10),
            Text(
              "Tanggal Selesai :",
              style: bigfont,
            ),
            Text(toDate(snapshot.data.tanggalSelesai)),
            SizedBox(
              height: 10,
            ),
            Text(
              "Url Donasi",
              style: bigfont,
            ),
            Text(snapshot.data.urlDonasi),
          ],
        ),
      ),
    );
  }
}
