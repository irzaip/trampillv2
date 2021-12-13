import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_message.dart';
import 'package:trampillv2/api/class_kegiatan.dart';
import 'package:trampillv2/api/api_listkegiatan.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:get/get.dart';
import 'package:trampillv2/values/fontstyle.dart';
import 'package:random_color/random_color.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:trampillv2/values/harga.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late Future<List<Materi>> listMateri;
  late List<Materi> fullList;
  String filterjudul = "";
  String valueText = "";
  List<String> kategories = [];
  String _selectedKategories = "";
  double listHeight = 200;
  double topContainer = 0;
  late Future<int> msgcount;
  final TextEditingController _textFieldController = TextEditingController();
  // late Future<List<Message>> messages;

  @override
  void initState() {
    //super.initState();
    listMateri = apiListMateri(context);
    msgcount = messageCount();
  }

  /// Memfilter Judul Materi berdasarkan String yang di ketik dari
  /// TextField yang berada pada Alert
  /// Proses pencarian berdasarkan variabel filterjudul
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Mencari'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  filterjudul = value.toLowerCase();
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "cari text..."),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedKategories = "";
                      filterjudul = "";
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Reset"))
            ],
          );
        });
  }

  /// Memfilter listMateri bedasarkan Tags yang ada pada data list.
  /// Bagian awal mengkonversi Future list menjadi list biasa
  /// Lalu membuat sebuat list berisikan data-data Tag (data)
  /// setelah itu proses SET agar tidak ada duplikasi lalu masukkan ke
  /// variabel kategories
  Future<void> _filterByCategory() async {
    kategories = [];
    fullList = await listMateri;
    var data = [];
    for (var element in fullList) {
      data.addAll(element.tags.cast().toList());
    }
    data = data.toSet().toList();
    for (var value in data) {
      kategories.add(value.toString());
    }
    if (_selectedKategories == "") {
      _selectedKategories = kategories[0].toString();
    }
    filterjudul = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Filter berdasarkan kategori'),
            content: DropdownButton<String>(
              value: _selectedKategories,
              items: kategories.map((value) {
                return DropdownMenuItem(child: Text(value), value: value);
              }).toList(),
              onChanged: (newvalue) {
                setState(() {
                  _selectedKategories = newvalue.toString();
                });
                Navigator.pop(context);
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedKategories = "";
                      filterjudul = "";
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Reset"))
            ],
          );
        });
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
                                    hitungdiscount(
                                        materi.harga, materi.discount),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trampill'),
        leading: FutureBuilder(
            future: msgcount,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return IconBadge(
                    itemCount: snapshot.data,
                    badgeColor: Colors.red,
                    itemColor: Colors.white,
                    hideZero: true,
                    onTap: () {
                      Get.toNamed('/message');
                    },
                    icon: const Icon(Icons.message));
              } else {
                return const Icon(Icons.message);
              }
            }),
        actions: [
          IconButton(
            onPressed: () {
              _displayTextInputDialog(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                _filterByCategory();
              },
              icon: const Icon(Icons.category)),
        ],
      ),
      body: Column(children: [
        FutureBuilder(
          future: listMateri,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              /* 
                  Proses Filtering dan Pengolahan ada di bagian ini. 
                  */
              var mydata = [];
              snapshot.data.forEach((e) => {
                    if (_selectedKategories == "" &&
                        (filterjudul == "" ||
                            e.judul.toLowerCase().contains(filterjudul)))
                      {mydata.add(e)}
                    else if (filterjudul == "" &&
                        e.tags.cast().toList().contains(_selectedKategories))
                      {mydata.add(e)}
                  });
              return Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: mydata.length + 1,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return scrollableKegiatan();
                  } else {
                    index = index - 1;
                    return materiCard(
                        context,
                        Materi(
                            id: mydata[index].id,
                            kode: mydata[index].kode,
                            judul: mydata[index].judul,
                            rating: mydata[index].rating,
                            pendek: mydata[index].pendek,
                            deskripsi: mydata[index].deskripsi,
                            gambar: mydata[index].gambar,
                            kategori: mydata[index].gambar,
                            copywrite: mydata[index].copywrite,
                            tags: mydata[index].tags,
                            harga: mydata[index].harga,
                            discount: mydata[index].discount,
                            pengajar: mydata[index].pengajar,
                            tentangPengajar: mydata[index].tentangPengajar,
                            hidden: mydata[index].hidden,
                            featured: mydata[index].featured,
                            frontpage: mydata[index].frontpage,
                            playlist: mydata[index].playlist,
                            password: mydata[index].password));
                  }
                },
              ));
            }
            if (snapshot.hasError) {
              return const Expanded(
                  child: Center(
                child: Text(
                    "Error loading, please check server setting or internet connection"),
              ));
            }
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          },
        ),
      ]),
    );
  }

  /// Ini berisikan Bagian Kegiatan yang bisa di scroll
  /// terdiri dari AnimatedContainer
  AnimatedContainer scrollableKegiatan() {
    return AnimatedContainer(
        height: listHeight,
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 200),
        child: const ListKegiatan());
  }
}

/// Class yang bertanggung jawab untuk Rendering Kegiatan pada awal Listview
/// semua berdasarkan ketinggian 200
class ListKegiatan extends StatefulWidget {
  const ListKegiatan({Key? key}) : super(key: key);

  @override
  State<ListKegiatan> createState() => _ListKegiatanState();
}

class _ListKegiatanState extends State<ListKegiatan> {
  late Future<List<Kegiatan>> kegiatans;
  final RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    kegiatans = getListKegiatan();
  }

  Widget cardKegiatan(kegiatan) {
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

  /// Ini adalah bagian build dari list kegiatan.
  /// FutureBuilder ditambah dengan ListView
  @override
  Widget build(BuildContext context) {
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
                  return cardKegiatan(snapshot.data[index]);
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
