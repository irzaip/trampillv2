import 'package:flutter/material.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:get/get.dart';

Widget materiCard(context, Materi materi) {

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
              child: Text(materi.judul),
            )
          ],
        ),
        Text(materi.pendek),
        Text(materi.pengajar),
        ElevatedButton(onPressed: () async {
          await Get.toNamed("/detailmateri", arguments: materi);
        }, 
        child: const Text("Buka"))
      ]));
}
