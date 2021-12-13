import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trampillv2/values/assets.dart';

class TentangScreen extends StatelessWidget {
  TentangScreen({Key? key}) : super(key: key);
  static const String routeName = '/tentang';
  final String _markdownData = """

# SIAPA KAMI?
Kami berangkat dari sebuah komunitas pembelajaran kecerdasan buatan INDOSOAI, komunitas kami berusaha untuk memajukan pendidikan di Indonesia dengan bantuan tools-tools moderen seperti apps, dan AI.

bergabunglah di komunitas kami di:

##  https://docs.google.com/forms/d/e/1FAIpQLSeqj1oG-nU2Vp1gsOjf9BTFZ1LXU_K2Uz0IoRTv4ckeGonIbw/viewform  

""";

  String url =
      'https://docs.google.com/forms/d/e/1FAIpQLSeqj1oG-nU2Vp1gsOjf9BTFZ1LXU_K2Uz0IoRTv4ckeGonIbw/viewform';

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Tentang kami'),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    imageIndosoai,
                    fit: BoxFit.fitWidth,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _launchURL();
                      },
                      child: const Text("KLIK DISINI UNTUK BERGABUNG")),
                  SizedBox(
                    height: 300,
                    child: Markdown(
                      controller: controller,
                      selectable: true,
                      data: _markdownData,
                      imageDirectory: 'https://raw.githubusercontent.com',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://docs.google.com/forms/d/e/1FAIpQLSeqj1oG-nU2Vp1gsOjf9BTFZ1LXU_K2Uz0IoRTv4ckeGonIbw/viewform';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
