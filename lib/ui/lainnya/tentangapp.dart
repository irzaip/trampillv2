import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';


class TentangAppScreen extends StatefulWidget {
  static const String routeName = '/tentangapp';
  @override
  _TentangAppScreenState createState() => _TentangAppScreenState();
}

class _TentangAppScreenState extends State<TentangAppScreen> {
  late String device_Id = "";

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    getDevice();
  }


  Future<void> getDevice() async {
    device_Id = "10029";
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 20),),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 18),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Tentang App ini")),
      body: Column(
        children: <Widget>[
          _infoTile("Device id", device_Id),
          _infoTile('App name', _packageInfo.appName),
          _infoTile('Package name', _packageInfo.packageName),
          _infoTile('App version', _packageInfo.version),
          _infoTile('Build number', _packageInfo.buildNumber),
        ],
      ),

    );
  }
}

