import 'package:flutter/material.dart';


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
              },
              child: const Text("TESTING")),
          ElevatedButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/materisaya");
              },
              child: const Text("Hello")),
        ],
      ),
    );
  }
}
