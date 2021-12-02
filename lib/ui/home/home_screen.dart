import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:trampillv2/api/api_listkegiatan.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:get/get.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:random_color/random_color.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late Future<List<Materi>> listMateri;
  late List<Materi> displayedMateri;
  double listHeight = 200;
  double topContainer = 0;

  @override
  void initState() {
    //super.initState();
    listMateri = apiListMateri(context);
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
                  const Icon(Icons.favorite),
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
                        const SizedBox(height: 10),
                        Text(
                          "Pengajar : " + materi.pengajar,
                          style: pengajar,
                        ),
                        const SizedBox(
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
                                  const SizedBox(width: 100),
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
                                      },
                                      child: const Text("Buka")),
                                  const SizedBox(width: 10),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trampill'),
          leading: const Icon(Icons.festival),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.category)),
          ],
        ),
        body: Container(
          child: Column(children: [
            FutureBuilder(
              future: listMateri,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                      child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (context, int index) {
                      if (index == 0) {
                        return scrollableKegiatan();
                      } else {
                        index = index - 1;
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
                      }
                    },
                  ));
                }
                if (snapshot.hasError) {
                  return Expanded(
                      child: const Center(
                    child: const Text(
                        "Error loading, please check server setting or internet connection"),
                  ));
                }
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ]),
        ));
  }

  AnimatedContainer scrollableKegiatan() {
    return AnimatedContainer(
        height: listHeight,
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 200),
        child: ListKegiatan());
  }
}

class ListKegiatan extends StatefulWidget {
  ListKegiatan({Key? key}) : super(key: key);

  @override
  State<ListKegiatan> createState() => _ListKegiatanState();
}

class _ListKegiatanState extends State<ListKegiatan> {
  late Future<List<Kegiatan>> kegiatans;
  // var color_index = 0;
  // var color_list = [
  //   Colors.grey[100],
  //   Colors.indigo[50],
  //   Colors.lightBlue[50],
  // ];

  // Colors cycleColor() {
  //   var cardcolor = color_list[color_index];
  //   color_index = color_index++;
  //   if (color_index > color_list.length) {
  //     color_index = 0;
  //   }
  //   return cardcolor;
  // }

  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    kegiatans = getListKegiatan();
  }

  Widget CardKegiatan(kegiatan) {
    Color _color =
        _randomColor.randomColor(colorBrightness: ColorBrightness.veryLight);
    return GestureDetector(
      onTap: () {
        Get.toNamed('/kegiatan', arguments: kegiatan);
      },
      child: Card(
        color: _color,
        borderOnForeground: true,
        elevation: 10,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Kegiatan: ",
                  style: titlefont,
                ),
                Text(kegiatan.judulAcara),
                const SizedBox(
                  height: 8,
                ),
                const Text("Tanggal :", style: titlefont),
                Text(toDate(kegiatan.tanggalMulai)),
                const Text('s/d'),
                Text(toDate(kegiatan.tanggalSelesai)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scrollheight = size.height * 0.25;
    return FutureBuilder(
        future: kegiatans,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, _) => const SizedBox(
                      width: 10,
                    ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return CardKegiatan(snapshot.data[index]);
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
