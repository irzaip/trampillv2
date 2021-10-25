import 'package:flutter/material.dart';
import 'package:trampillv2/ui/home/home_body.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trampill'),
      ),
      body: HomeBodyWidget(),
    );
  }
}
