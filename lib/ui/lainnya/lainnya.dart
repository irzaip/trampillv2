import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LainnyaWidget extends StatelessWidget {
  const LainnyaWidget({Key? key}) : super(key: key);
  static const routeName = '/lainnya';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Lainnya..."),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Get.toNamed('/login');
                      },
                      child: const Text("LOGIN")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/setting');
                      }, child: const Text("Settings")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/profile');
                      }, child: const Text("Akun Saya")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/tentang');
                      },
                      child: const Text("Tentang kami")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/hubungikami');
                      },
                      child: const Text("Hubungi kami")),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("Cara Membuat kelas")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/privasi');
                      },
                      child: const Text("Privasi")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/syaratketentuan');
                      },
                      child: const Text("Syarat & Ketentuan")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/tentangapp");
                      },
                      child: const Text("Tentang Aplikasi ini")),
                  ],
              ))),
    );
  }
}
