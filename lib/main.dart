import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trampillv2/ui/dashboard/dashboard_screen.dart';
import 'package:trampillv2/ui/favorit/favorit.dart';
import 'package:trampillv2/ui/home/home_screen.dart';
import 'package:trampillv2/ui/lainnya/hubungikami.dart';
import 'package:trampillv2/ui/lainnya/lainnya.dart';
import 'package:trampillv2/ui/lainnya/privasi.dart';
import 'package:trampillv2/ui/lainnya/setting.dart';
import 'package:trampillv2/ui/lainnya/syaratketentuan.dart';
import 'package:trampillv2/ui/lainnya/tentang.dart';
import 'package:trampillv2/ui/lainnya/tentangapp.dart';
import 'package:trampillv2/ui/login/forgot_screen.dart';
import 'package:trampillv2/ui/login/login_screen.dart';
import 'package:trampillv2/ui/login/register_screen.dart';
import 'package:trampillv2/ui/materi/detail_materi.dart';
import 'package:trampillv2/ui/materi/materi_screen.dart';
import 'package:trampillv2/ui/materisaya/materi_saya.dart';
import 'package:trampillv2/ui/pembayaran/pembayaran_screen.dart';
import 'package:trampillv2/ui/kegiatan/kegiatan.dart';
import 'ui/kegiatan/listkegiatan.dart';
import 'package:trampillv2/ui/message/message.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/", page: () => DashboardScreen()),
        GetPage(name: "/materi", page: () => const MateriScreen()),
        GetPage(name: "/home", page: () => const HomeScreenWidget()),
        GetPage(name: "/favorit", page: () => const FavoritScreen()),
        GetPage(name: "/materisaya", page: () => const MateriSayaScreen()),
        GetPage(name: "/pembayaran", page: () => const PembayaranScreen()),
        GetPage(name: "/lainnya", page: () => const LainnyaWidget()),
        GetPage(name: "/login", page: () => const LoginScreen()),
        GetPage(name: "/detailmateri", page: () => const DetailMateriScreen()),
        GetPage(name: "/forgot", page: () => const ForgotScreen()),
        GetPage(name: "/hubungikami", page: () => HubungiKamiScreen()),
        GetPage(name: "/privasi", page: () => PrivasiScreen()),
        GetPage(name: "/syaratketentuan", page: () => SyaratKetentuanScreen()),
        GetPage(name: "/tentang", page: () => TentangScreen()),
        GetPage(name: "/tentangapp", page: () => TentangAppScreen()),
        GetPage(name:"/kegiatan", page: () => const KegiatanScreen()),
        GetPage(name: "/listkegiatan", page: () => ListKegiatanScreen()),
        GetPage(name: "/register", page: () => const RegisterScreen()),
        GetPage(name: "/setting" , page: () => SettingScreen()),
        GetPage(name: "/message" , page: () => const MessageScreen()),
      ],
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: Routes.generateRoute,
    );
  }
}
