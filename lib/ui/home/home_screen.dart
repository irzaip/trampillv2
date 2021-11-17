import 'package:flutter/material.dart';
import 'package:trampillv2/ui/home/home_body.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trampill'),
        leading: Icon(Icons.festival),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search),),
          IconButton(onPressed: (){}, 
          icon: Icon(Icons.category)),
        ],

      ),
      body: const HomeBodyWidget(),
    );
  }
}
