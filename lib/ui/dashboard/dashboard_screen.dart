import 'package:flutter/material.dart';
import 'package:trampillv2/api/httpapi.dart';
import 'package:trampillv2/ui/home/home_screen.dart';
import 'package:trampillv2/ui/iqro/iqro.dart';
import 'package:trampillv2/ui/lainnya/lainnya.dart';
import 'package:trampillv2/ui/materisaya/materi_saya.dart';
import 'package:trampillv2/ui/pembayaran/pembayaran_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';
  // ignore: prefer_typing_uninitialized_variables
  late var loggedin;

  @override
  void initState() {
    //super.initState();
    loggedin = relogin();
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndexBody = 0;

  final List<Widget> _dashboardBodyWidgets = <Widget>[
    const HomeScreenWidget(),
    const MateriSayaScreen(),
    const IqroScreen(),
    const PembayaranScreen(),
    const LainnyaWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _dashboardBodyWidgets[_selectedIndexBody],
        // IndexedStack(
        //   index: _selectedIndexBody,
        //   children: _dashboardBodyWidgets,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: Colors.amber[800],
          type: BottomNavigationBarType.fixed,
          items: _mainMenuItems(),
          currentIndex: _selectedIndexBody,
          onTap: (index) {
            setState(() {
              _selectedIndexBody = index;
            });
          },
          showUnselectedLabels: true,
          showSelectedLabels: true,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _mainMenuItems() {
    return <BottomNavigationBarItem>[
      _mainMenuItemWidget('Beranda', Icons.home),
      _mainMenuItemWidget('Materi', Icons.school),
      _mainMenuItemWidget('IQRO', Icons.receipt_sharp),
      _mainMenuItemWidget('Pembelian', Icons.payment),
      _mainMenuItemWidget('Lainnya...', Icons.more_horiz),
    ];
  }

  BottomNavigationBarItem _mainMenuItemWidget(
      String menuTitle, IconData iconData) {
    return BottomNavigationBarItem(
      activeIcon: Icon(iconData),
      icon: Icon(iconData),
      label: menuTitle,
    );
  }
}
