import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const  TextStyle titlefont = TextStyle(
      fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle bigfont = TextStyle(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle mediumfont = TextStyle(fontSize: 14, color: Colors.black);
const  TextStyle mediumfontbold = TextStyle(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle kategorifont = TextStyle(fontSize: 13, color: Colors.blueGrey);
const TextStyle pengajar = TextStyle(
    fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.w700);
const TextStyle hargafont = TextStyle(
    fontSize: 20, color: Colors.redAccent, fontWeight: FontWeight.w700);
const TextStyle hargacoret = TextStyle(
    fontSize: 20,
    color: Colors.redAccent,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.lineThrough);
const TextStyle linkfont = TextStyle(fontSize: 16, color: Colors.blueGrey);

  /// Fungsi Merubah String json <2021-04-01 00:00:00> datetime menjadi bentuk dd-mmm-yyyy
  String toDate(dstr) {
    var parsedDate = DateTime.parse(dstr);
    final formater = DateFormat('dd-MMM-yyyy');
    return formater.format(parsedDate).toString();
  }


  