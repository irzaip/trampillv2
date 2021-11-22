import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TentangAppScreen extends StatelessWidget {
  const TentangAppScreen({Key? key}) : super(key: key);
  static const String routeName = '/tentangapp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/listkegiatan');
              },
              child: const Text("TESTING")),
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/kegiatan');
              },
              child: const Text("Hello")),
        ],
      ),
    );
  }
}
