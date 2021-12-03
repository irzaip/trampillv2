import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trampillv2/api/class_topic.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trampillv2/api/class_materi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trampillv2/values/fontstyle.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);
  static const routeName = '/materi';

  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  late Future<Object> resultmateri;
  late Materi materi;
  late Topic topic;
  final PageController _pageController = PageController();

  @override
  void initState() {
    materi = Get.arguments;
    resultmateri = apiMainMateri(materi.id);
    super.initState();
  }

  Future<List<Topic>> apiMainMateri(id) async {
    var prefs = await SharedPreferences.getInstance();
    final String api = '/api/topic/' + id.toString();
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();

    final request = await http.get(Uri.parse(mainhome + api),
        headers: {HttpHeaders.authorizationHeader: fulltoken});

    if (request.statusCode == 200) {
      if (request.body == '{"status":"Belum terdaftar"}') {
        throw ("Anda harus mendaftar materi ini terlebih dahulu");
      }
      var result = compute(parseTopic, request.body);
      return result;
    } else if (request.statusCode == 401) {
      throw ("Error loading materi, not login?");
    } else {
      throw ("Errow Loading, belum terdaftar");
    }
  }

  Widget playYoutube(url_youtube, judul) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(url_youtube) ?? "";
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(judul.toString(), style: bigfont),
            const SizedBox(
              height: 30,
            ),
            player,
          ]);
        });
  }

_launchURL(open_url) async {
  var url = open_url.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  Widget pageCard(topic) {
    if (topic.jenis.toString() == 'Label') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Text(
          topic.judul.toString(),
          style: bigfont,
        ),
        ],
      );
    } else if (topic.jenis.toString() == 'Link Video' &&
        topic.link.toString().contains('youtube')) {
      return playYoutube(topic.link.toString(), topic.judul.toString());
    } else if (topic.jenis.toString() == 'Konten Umum') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(topic.judul.toString(), style: bigfont),
        Text(topic.link.toString(), style: linkfont),
        ElevatedButton(onPressed: () {
          _launchURL(topic.link.toString());
        }, child: const Text("Buka")),
        const SizedBox(height: 20),
        Text(topic.isiTambahan.toString(), style: mediumfont,)
      ]);
    } else if (topic.jenis.toString() == 'Tugas') {
      return Center(child: Text(topic.judul.toString(), style: bigfont,));
    } else if (topic.jenis.toString() == 'Quiz') {
      return Center(child: Text(topic.judul.toString(), style: bigfont,));
    } else if (topic.jenis.toString() == 'Feedback') {
      return Center(child: Text(topic.judul.toString(), style: bigfont,));
    } else if (topic.jenis.toString() == 'Url luar') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(topic.judul.toString(), style: bigfont,),
        Text(topic.link.toString(), style: mediumfont,),
        ElevatedButton(onPressed: () {
          _launchURL(topic.link.toString());
        }, child: const Text("Buka"))
      ]);

    } else if (topic.jenis.toString() == 'File') {
      return Center(child: Text(topic.judul.toString()));
    } else {
      return Center(
        child: Text(
          topic.judul.toString(),
          style: mediumfont,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(materi.judul),
      ),
      body: FutureBuilder(
          future: resultmateri,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return PageView.builder(
                  controller: _pageController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: pageCard(snapshot.data[index]),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError &&
                snapshot.error.toString().contains('login')) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(height: 150),
                  Text(snapshot.error.toString()),
                  ElevatedButton(
                      onPressed: () async {
                        var result = await Get.offNamed('/login');
                        if (result  == "success") {
                          Get.close(1);
                          Get.snackbar(
                          "STATUS",
                          "Login Berhasil",
                          icon: Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          borderRadius: 20,
                          margin: EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
                          isDismissible: true,
                          dismissDirection: SnackDismissDirection.HORIZONTAL,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );
              
                        }
                      },
                      child: const Text("Login"))
                ],
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                      duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                },
                child: const Icon(Icons.arrow_left)),
            const ElevatedButton(onPressed: null, child: Icon(Icons.topic)),
            ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                },
                child: const Icon(Icons.arrow_right)),
          ],
        ),
      ),
    );
  }
}
