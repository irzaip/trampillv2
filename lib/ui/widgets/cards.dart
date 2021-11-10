import 'package:flutter/material.dart';

Widget materiCard(judul, pengajar, pendek) {
  return Card(
      elevation: 10,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        Row(
          children: [
            const Icon(
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
