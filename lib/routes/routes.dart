import 'package:flutter/material.dart';
import 'package:trampillv2/ui/dashboard/dashboard_screen.dart';
import 'package:trampillv2/ui/splashscreen/splash_screen.dart';
import 'package:trampillv2/ui/materi/materi_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case MateriScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MateriScreen());
    }
  }
}
