import 'package:flutter/material.dart';
import 'package:trampillv2/ui/favorit/favorit.dart';
import 'package:trampillv2/ui/home/home_screen.dart';
import 'package:trampillv2/ui/lainnya/lainnya_dart.dart';
import 'package:trampillv2/ui/materisaya/materi_saya.dart';
import 'package:trampillv2/ui/pembayaran/pembayaran_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndexBody = 0;

  final List<Widget> _dashboardBodyWidgets = <Widget>[
    HomeScreenWidget(),
    MateriSayaScreen(),
    FavoritScreen(),
    PembayaranScreen(),
    LainnyaWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndexBody,
        children: _dashboardBodyWidgets,
      ),
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
    );
  }

  List<BottomNavigationBarItem> _mainMenuItems() {
    return <BottomNavigationBarItem>[
      _mainMenuItemWidget('Beranda', Icons.home),
      _mainMenuItemWidget('Materi Saya', Icons.school),
      _mainMenuItemWidget('Favorit',Icons.favorite),
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
