import 'package:flutter/material.dart';


class MembuatKelasScreen extends StatelessWidget {
  MembuatKelasScreen({Key? key}) : super(key: key);
  static const String routeName = '/membuatkelas';
  final TextEditingController _urlSender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cara Membuat Kelas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Langkah membuat kelas :"),
            const Text("Masukkan Url Youtube PLAYLIST disini lalu kirim ke kami. Dan tunggu kami periksa dan kami tampilkan"),
            TextField(controller: _urlSender,),
            ElevatedButton(onPressed: () {

            }, child: const Text("Kirim")),
            const SizedBox(height: 40,),
            const Text("atau Tunggu App TrampillAdmin kami."),
          ],
        ),
      ),
    );
  }
}