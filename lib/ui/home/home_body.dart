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
                return materiCard(snapshot.data[index].judul,
                    snapshot.data[index].pengajar, snapshot.data[index].pendek);
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
