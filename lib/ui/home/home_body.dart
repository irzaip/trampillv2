import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:get/get.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late Future<List<Materi>> listMateri;
  TextStyle bigfont = const TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
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
  ScrollController controller = ScrollController();
  bool closeTopList = false;
  double listHeight = 200;
  double topContainer = 0;

  @override
  void initState() {
    //super.initState();
    listMateri = apiListMateri(context);
    controller.addListener(() {

      setState(() {
        print(controller.offset.toString());
        closeTopList = controller.offset > 0;
        print(closeTopList.toString());
        // listHeight = 200 - (controller.offset * 10);
        // if (listHeight < 0) {
        //   listHeight = 0;
        // };
        if (closeTopList == true) {
          listHeight = 0;
        }
      });
    });
  }

  /// Fungsi menghitung discount dan menampilkan dalam bentuk string
  String hitungharga(harga, discount) {
    var total = harga - (harga * discount / 100);
    if (harga != 0 && discount != 100) {
      total = total.floor();
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(harga)
          .toString();
    } else {
      return "Gratis";
    }
  }

  /// Fungsi menghitung discount dan menampilkan dalam bentuk string
  String discount(harga, discount) {
    var total = harga - (harga * discount / 100);
    total = total.floor();
    if (total != 0) {
      total = total.floor();
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(total)
          .toString();
      // return discount.toString();
    } else {
      return "";
    }
  }

  /// menampilkan harga dalam bentuk coret, apabila berlaku discount.
  TextStyle fontharga(harga, discount) {
    if (harga != 0 && discount != 0 && discount != 100) {
      return hargacoret;
    } else {
      return hargafont;
    }
  }

  /// menampilkan card listmateri
  Widget materiCard(context, Materi materi) {
    return Card(
        elevation: 10,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.favorite),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          materi.judul,
                          style: bigfont,
                        ),
                        Text(
                          materi.tags
                              .cast()
                              .toString()
                              .replaceFirst('[', '')
                              .replaceFirst(']', ''),
                          style: kategorifont,
                        ),
                        Text(
                          materi.pendek,
                          style: mediumfont,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Pengajar : " + materi.pengajar,
                          style: pengajar,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    hitungharga(materi.harga, materi.discount),
                                    style: fontharga(
                                        materi.harga, materi.discount),
                                  ),
                                  Text(
                                    discount(materi.harga, materi.discount),
                                    style: hargafont,
                                  ),
                                  SizedBox(width: 100),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await Get.toNamed("/detailmateri",
                                            arguments: materi);
                                        setState(() {});
                                      },
                                      child: const Text("Buka")),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  double calcheight(value) {
    var height;
    height = 200 - value;
    if (height < 0) {
      height = 0;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: closeTopList ? 0 : 1,
          child: AnimatedContainer(
              height: listHeight,
              alignment: Alignment.topCenter,
              duration: Duration(milliseconds: 200),
              child: ListKegiatan()),
        ),
        FutureBuilder(
          future: listMateri,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Expanded(
                child: ListView.builder(
                    controller: controller,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return materiCard(
                          context,
                          Materi(
                              id: snapshot.data[index].id,
                              kode: snapshot.data[index].kode,
                              judul: snapshot.data[index].judul,
                              rating: snapshot.data[index].rating,
                              pendek: snapshot.data[index].pendek,
                              deskripsi: snapshot.data[index].deskripsi,
                              gambar: snapshot.data[index].gambar,
                              kategori: snapshot.data[index].gambar,
                              copywrite: snapshot.data[index].copywrite,
                              tags: snapshot.data[index].tags,
                              harga: snapshot.data[index].harga,
                              discount: snapshot.data[index].discount,
                              pengajar: snapshot.data[index].pengajar,
                              tentangPengajar:
                                  snapshot.data[index].tentangPengajar,
                              hidden: snapshot.data[index].hidden,
                              featured: snapshot.data[index].featured,
                              frontpage: snapshot.data[index].frontpage,
                              playlist: snapshot.data[index].playlist));
                    }),
              );
            }
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Error loading")));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}

class ListKegiatan extends StatefulWidget {
  ListKegiatan({Key? key}) : super(key: key);

  @override
  State<ListKegiatan> createState() => _ListKegiatanState();
}

class _ListKegiatanState extends State<ListKegiatan> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scrollheight = size.height * 0.25;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        child: FittedBox(
          child: Row(
            children: [
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.cyan,
              ),
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.deepPurple,
              ),
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.indigo,
              ),
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.cyan,
              ),
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.deepPurple,
              ),
              Container(
                height: scrollheight,
                width: 200,
                child: Text("Hello"),
                color: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
