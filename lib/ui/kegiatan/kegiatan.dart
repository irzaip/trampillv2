import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:flutter/foundation.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:trampillv2/api/api_listkegiatan.dart';
import 'package:get/get.dart';

class KegiatanScreen extends StatefulWidget {
  const KegiatanScreen({Key? key}) : super(key: key);
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
          IconButton(
              onPressed: () {
                Get.offNamed('/listkegiatan');
              },
              icon: const Icon(Icons.list))
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

  Widget detailKegiatan(AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Kegiatan :",
            style: bigfont,
          ),
          Text(
            snapshot.data.judulAcara,
            style: titlefont,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Status :",
            style: bigfont,
          ),
          Text(snapshot.data.statusAcara, style: mediumfont),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Judul Materi :",
            style: bigfont,
          ),
          Text(
            snapshot.data.judulMateri,
            style: mediumfont,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Deskripsi :", style: bigfont),
          Text(
            snapshot.data.deskripsi,
            style: mediumfont,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Rating :",
            style: bigfont,
          ),
          Text(
            snapshot.data.rating.toString(),
            style: mediumfont,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Tanggal Mulai :", style: bigfont),
          Text(toDate(snapshot.data.tanggalMulai)),
          const SizedBox(height: 10),
          const Text(
            "Tanggal Selesai :",
            style: bigfont,
          ),
          Text(toDate(snapshot.data.tanggalSelesai)),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Url Donasi",
            style: bigfont,
          ),
          Text(snapshot.data.urlDonasi),
        ],
      ),
    );
  }
}
