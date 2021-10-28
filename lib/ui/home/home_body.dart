import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/httpapi.dart';


class HomeBodyWidget extends StatefulWidget {
  HomeBodyWidget({Key? key}) : super(key: key);
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
 }

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late Future<List<Materi>> listMateri;

  _HomeBodyWidgetState() {
    initpref();
  }


@override
void initState() {
    super.initState();
    listMateri = apiListMateri();
    print(listMateri);
  }

@override
Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: listMateri,
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data.length ,
                itemBuilder: (context, int index) {
                  return addCard(
                    snapshot.data[index].judul,
                    snapshot.data[index].pengajar,
                    snapshot.data[index].pendek
                    );
                } 
              );
          }
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text("Error loading"))
            );
          }
          return Center(child: CircularProgressIndicator());
          }
        
      ),
    );
}




Widget addCard(judul, pengajar, pendek) {
  return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        Row(
          children: [
            Icon(
              Icons.ac_unit,
              color: Colors.black,
              size: 50,
            ),
            Expanded(
              child: Text(judul),
            )
          ],
        ),
        Text(pendek),
        Text(pengajar),
      ]));
}
}


