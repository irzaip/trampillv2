import 'package:flutter/material.dart';


class LainnyaWidget extends StatelessWidget {
  const LainnyaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPLL"),
      ), 
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/login');
            }, 
            child: Text("Login"))
        ],
      ),
    );
  }
}

