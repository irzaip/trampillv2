import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/httpapi.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _controller_user;
  late TextEditingController _controller_pass;

  bool loggedin = false;
  String fUsername = "";
  String fPassword = "";

@override
  void initState() {
    fillField();
    _controller_user = new TextEditingController();
    _controller_pass = new TextEditingController();
    super.initState();
  }


  Future<void> fillField() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username  = prefs.getString("username").toString();
    String password  = prefs.getString("password").toString();

    if (username != "null") {
      fUsername = username;
      fPassword = password;
    }

    _controller_user.text = fUsername;
    _controller_pass.text = fPassword;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
      ),
      body: Column(children: [
        TextField(
          controller: _controller_user,
          onChanged: (String value) {
            fUsername = value;
          },
          obscureText: false,
          decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'username',
         ),
        ),
        TextField(
          controller: _controller_pass,
          onChanged: (String value) {
            fPassword = value;
          },
          obscureText: true,
          decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
         ),
        ),
        ElevatedButton(
          onPressed: () async {
               SharedPreferences prefs = await SharedPreferences.getInstance();
               try {
               loggedin = await sendlogin(fUsername, fPassword);

                if (loggedin == true) {
                  prefs.setString("username", fUsername);
                  prefs.setString("password", fPassword);
 
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login Sukses."),)
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login Gagal ! - Username or Password Error"),)
                  );
                }
               }
               catch (e) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text("Error Connect to server"),)
                 );
                Navigator.pop(context);
               }
                setState(() {});
          }, 
          child: const Text("Login"))
      ],),
    );
  }
}
