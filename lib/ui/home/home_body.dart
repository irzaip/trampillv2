import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_listmateri.dart';
import 'package:trampillv2/api/httpapi.dart';


class HomeBodyWidget extends StatefulWidget {
  HomeBodyWidget({Key? key}) : super(key: key);
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  List<Widget> daftarmateri = [];


  _HomeBodyWidgetState() {
    initpref();
  }


@override
void initState() {
    super.initState();
  }

@override
Widget build(BuildContext context) {
    return ListView();
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