
import 'package:flutter/cupertino.dart';

class IqroScreen extends StatefulWidget {
  IqroScreen({Key? key}) : super(key: key);
  static const String routeName = '/iqro';

  @override
  _IqroScreenState createState() => _IqroScreenState();
}

class _IqroScreenState extends State<IqroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("IQRO1"));
  }
}