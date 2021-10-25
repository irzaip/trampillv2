import 'package:flutter/material.dart';

class MateriScreen extends StatelessWidget {
  const MateriScreen({Key? key}) : super(key: key);
  static const String routeName = '/materi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Python Dasar"),
      ),
      body: MainMateriScreen(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ElevatedButton(onPressed: null, child: Icon(Icons.arrow_back)),
            ElevatedButton(onPressed: null, child: Icon(Icons.assignment)),
            ElevatedButton(onPressed: null, child: Icon(Icons.forward)),
          ],
        ),
      ),
    );
  }
}

Widget textPage() {
  return const Text("Okeee");
}

Widget urlPage() {
  return const Text("This is my URL");
}

Widget wasPage() {
  return const Text("This page WAS");
}

class MainMateriScreen extends StatefulWidget {
  MainMateriScreen({Key? key}) : super(key: key);
  int bottomSelectedIndex = 0;

  @override
  _MainMateriScreenState createState() => _MainMateriScreenState();
}

class _MainMateriScreenState extends State<MainMateriScreen> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        ElevatedButton(
          onPressed: () async {
          }, 
          child: Text("Test"),
          ),
        wasPage(),
        urlPage(),
        textPage(),
      ],
    );
  }
}
