import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/values/fontstyle.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);
  static const String routeName = '/setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  late Future<String> mainhome;
  late Future<String> custombuild;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

@override
void initState() {
  super.initState();
  getMainServer().then((value) {_controller.text = value;});
  getCustomBuild().then((value) {_controller2.text = value;});
}

  Future<String> getMainServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mainhome = prefs.getString("mainhome").toString();
    return mainhome;
  }

  Future<String> getCustomBuild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final custombuild = prefs.getString("custombuild").toString();
    return custombuild;
  }


  @override
  Widget
   build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text("Main Server", style: titlefont,),
          TextField(controller: _controller,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.text = "https://neo.trampill.com";
                }, 
                child: const Text("default")),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  _controller.text = prefs.getString("mainhome").toString();
                }, 
                child: const Text("load")),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString("mainhome", _controller.text);
                }, 
                child: const Text("save")),
              ElevatedButton(
                onPressed: () {}, 
                child: const Text("Scan QR")),
            ],
          ),
          SizedBox(height: 30,),
          const Text("Custom Build", style: titlefont),
          TextField(
            controller: _controller2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("default"),),
              ElevatedButton(onPressed: () {}, child: const Text("load"),),
              ElevatedButton(onPressed: () {}, child: const Text("save"),),
              ElevatedButton(onPressed: () {}, child: const Text("Scan QR"),),
            ],)

        ],),
      ),
    );
  }
}