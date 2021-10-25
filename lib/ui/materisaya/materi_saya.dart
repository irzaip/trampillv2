import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MateriSayaScreen extends StatelessWidget {
  const MateriSayaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
        ),
      body: ListView(children: [
        Text("Test"),
      ],),
      );
  }
}

