import 'package:flutter/material.dart';
import 'package:trampillv2/ui/dashboard/dashboard_screen.dart';
import 'package:trampillv2/ui/lainnya/hubungikami.dart';
import 'package:trampillv2/ui/lainnya/syaratketentuan.dart';
import 'package:trampillv2/ui/lainnya/tentangapp.dart';
import 'package:trampillv2/ui/login/login_screen.dart';
import 'package:trampillv2/ui/materisaya/materi_saya.dart';
import 'package:trampillv2/ui/splashscreen/splash_screen.dart';
import 'package:trampillv2/ui/materi/materi_screen.dart';
import 'package:trampillv2/ui/lainnya/privasi.dart';
import 'package:trampillv2/ui/lainnya/tentang.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case MateriScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MateriScreen());
      case PrivasiScreen.routeName:
        return MaterialPageRoute(builder: (_) => PrivasiScreen());
      case TentangScreen.routeName:
        return MaterialPageRoute(builder: (_) => TentangScreen());
      case SyaratKetentuanScreen.routeName:
        return MaterialPageRoute(builder: (_) => SyaratKetentuanScreen());
      case HubungiKamiScreen.routeName:
        return MaterialPageRoute(builder: (_) => HubungiKamiScreen());
      case TentangAppScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TentangAppScreen());
      case MateriSayaScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MateriSayaScreen());
    }
  }
}
