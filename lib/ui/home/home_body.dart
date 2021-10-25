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
    daftarmateri.add(ElevatedButton(
      onPressed: () async {
        
        final bool loggedin;
        //Navigator.pushNamed(context, MateriScreen.routeName, arguments: "Hello arguments");
        loggedin = await sendlogin('teststudent', 'test1001');

        if (loggedin == true) {
          List<ListMateri> result = await ApiListMateri();
          for (int i = 0; i < 10; i++) {
              daftarmateri.add(addCard(result[i].judul, result[i].pengajar, result[i].pendek));
        }
        }
        setState(() {});
      },
      child: const Text("Print"),
    ));

    daftarmateri
        .add(ElevatedButton(onPressed: () async {}, child: Text("Test 2")));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: daftarmateri,
    );
  }
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
