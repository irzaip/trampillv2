import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:trampillv2/ui/widgets/cards.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late Future<List<Materi>> listMateri;

  @override
  void initState() {
    //super.initState();
    listMateri = apiListMateri(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listMateri,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                return materiCard(
                    context,
                    Materi(
                      id: snapshot.data[index].id,
                      kode: snapshot.data[index].kode,
                      judul: snapshot.data[index].judul,
                      rating: snapshot.data[index].rating,
                      pendek: snapshot.data[index].pendek ,
                      deskripsi: snapshot.data[index].deskripsi,
                      gambar: snapshot.data[index].gambar,
                      kategori: snapshot.data[index].gambar,
                      copywrite: snapshot.data[index].copywrite,
                      tags: snapshot.data[index].tags,
                      harga: snapshot.data[index].harga,
                      discount: snapshot.data[index].discount,
                      pengajar: snapshot.data[index].pengajar,
                      tentangPengajar: snapshot.data[index].tentangPengajar,
                      hidden: snapshot.data[index].hidden,
                      featured: snapshot.data[index].featured,
                      frontpage: snapshot.data[index].frontpage,
                      playlist: snapshot.data[index].playlist
                      ));
              });
        }
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Error loading")));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
