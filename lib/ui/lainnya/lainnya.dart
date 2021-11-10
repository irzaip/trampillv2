import 'package:flutter/material.dart';

class LainnyaWidget extends StatelessWidget {
  const LainnyaWidget({Key? key}) : super(key: key);
  static const routeName = '/lainnya';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPLL"),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/login');
                      },
                      child: const Text("LOGIN")),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Settings")),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Akun Saya")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tentang');
                      },
                      child: const Text("Tentang kami")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/hubungikami');
                      },
                      child: const Text("Hubungi kami")),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("Cara Membuat kelas")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/privasi');
                      },
                      child: const Text("Privasi")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/syaratketentuan');
                      },
                      child: const Text("Syarat & Ketentuan")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/tentangapp");
                      },
                      child: const Text("Tentang Aplikasi ini")),
                ],
              ))),
    );
  }
}
