import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:flutter/foundation.dart';
import 'package:trampillv2/api/api_listkegiatan.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:get/get.dart';

class ListKegiatanScreen extends StatefulWidget {
  ListKegiatanScreen({Key? key}) : super(key: key);
  static const routeName = '/listkegiatan';

  @override
  _ListKegiatanScreenState createState() => _ListKegiatanScreenState();
}

class _ListKegiatanScreenState extends State<ListKegiatanScreen> {
  late Future<List<Kegiatan>> kegiatan;

@override
void initState() {
  super.initState();
  kegiatan = getListKegiatan();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kegiatan"),
      ),
      body: FutureBuilder(
        future: kegiatan,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.offNamed('/kegiatan', arguments: snapshot.data[index]);
                    },
                    child: Card(
                      elevation: 10,
                      borderOnForeground: true,
                      child: detailKegiatan(snapshot.data[index])),
                  ),
                );

              }); 


          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }

        },)
      ,);
  }

  Container detailKegiatan(snapshot) {
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
              snapshot.judulAcara,
              style: titlefont,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Status :",
              style: bigfont,
            ),
            Text(snapshot.statusAcara, style: mediumfont),
            SizedBox(
              height: 10,
            ),
            Text(
              "Judul Materi :",
              style: bigfont,
            ),
            Text(
              snapshot.judulMateri,
              style: mediumfont,
            ),
            SizedBox(
              height: 10,
            ),
            // Text("Deskripsi :", style: bigfont),
            // Text(
            //   snapshot.deskripsi,
            //   style: mediumfont,
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "Rating :",
            //   style: bigfont,
            // ),
            // Text(
            //   snapshot.rating.toString(),
            //   style: mediumfont,
            // ),
            SizedBox(
              height: 10,
            ),
            Text("Tanggal Mulai :", style: bigfont),
            Text(toDate(snapshot.tanggalMulai)),
            SizedBox(height: 10),
            Text(
              "Tanggal Selesai :",
              style: bigfont,
            ),
            Text(toDate(snapshot.tanggalSelesai)),
            SizedBox(
              height: 10,
            ),
            // Text(
            //   "Url Donasi",
            //   style: bigfont,
            // ),
            // Text(snapshot.urlDonasi),
          ],
        ),
      ),
    );
  }


}