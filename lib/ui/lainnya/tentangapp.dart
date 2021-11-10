import 'package:flutter/material.dart';
import 'package:trampillv2/api/login_provider.dart';
import 'package:provider/provider.dart';

class TentangAppScreen extends StatelessWidget {
  const TentangAppScreen({Key? key}) : super(key: key);
  static const String routeName = '/tentangapp';

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of<LoginState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                loginState.tulis("Hello man");
              },
              child: const Text("TESTING")),
          ElevatedButton(
              onPressed: () {
                loginState.tulis("Hello brow");
                Navigator.popAndPushNamed(context, "/materisaya");
              },
              child: const Text("Hello")),
        ],
      ),
    );
  }
}
