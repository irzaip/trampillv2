import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HubungiKamiScreen extends StatelessWidget {
  const HubungiKamiScreen({Key? key}) : super(key: key);
  static const String routeName = '/hubungikami';

  final String myText = """
  
# Pengembang.
### irzaip@gmail.com - Irza Pulungan
### asman13300045@gmail.com - M. Asman
### erisriso@gmail.com - Eris Riso
### alternative.xen@gmail.com - Riska Abdullah
### Imam Akbar Mega Antariksa
  
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hubungi Kami"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 30, 30),
        alignment: Alignment.topLeft,
        child: Markdown(data: myText),
      ),
    );
  }
}
