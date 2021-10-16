import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TRMPLL",
      initialRoute: "/",
      routes: {
        "/": (context) => MyStatefulWidget(),
      },

    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({ Key? key }) : super(key: key);


  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = 0;
  var defUrlMasterMooc =
      "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 1) {
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>
            //Pg7KelasSaya("Masih dalam Konstruksi"))) ;
      }
      if (_selectedIndex == 2) {
        //Navigator.pushNamed(context, '/pg8_pembelian');
      }
      if (_selectedIndex == 3) {
        //Navigator.pushNamed(context, '/pg3_lainnya');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
        
      ),
      body: Container(
        child: Center(child: Text("Hilux"),),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
              //title: Text("Beranda"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "Kelas Saya",
              //title: Text("Kelas saya"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: "Pembelian",
              //title: Text("Pembelian")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "Lainnya...",
              //title: Text("Lainnya"),
            ),
          ],
      currentIndex:  _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      ),  
    );
  }
}