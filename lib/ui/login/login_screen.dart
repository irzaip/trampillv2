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
  late TextEditingController _controllerUser;
  late TextEditingController _controllerPass;

  bool loggedin = false;
  String fUsername = "";
  String fPassword = "";

  @override
  void initState() {
    fillField();
    _controllerUser = TextEditingController();
    _controllerPass = TextEditingController();
    super.initState();
  }

  Future<void> fillField() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username").toString();
    String password = prefs.getString("password").toString();

    if (username != "null") {
      fUsername = username;
      fPassword = password;
    }

    _controllerUser.text = fUsername;
    _controllerPass.text = fPassword;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRMPL"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextField(
              controller: _controllerUser,
              onChanged: (String value) {
                fUsername = value;
              },
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'username',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _controllerPass,
              onChanged: (String value) {
                fPassword = value;
              },
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  try {
                    loggedin = await sendlogin(fUsername, fPassword);

                    if (loggedin == true) {
                      prefs.setString("username", fUsername);
                      prefs.setString("password", fPassword);
                      
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Login Sukses."),
                      ));

                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Login Gagal ! - Username or Password Error"),
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Error Connect to server"),
                    ));
                    Navigator.pop(context);
                  }
                  setState(() {});
                },
                child: const Text("LOGIN")),
            ElevatedButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.setString("username", "null");
                  await prefs.setString("password", "null");
                  await prefs.setString("access", "null");
                  await prefs.setString("refresh", "null");
                  Navigator.pop(context);
                },
                child: const Text("LOGOUT")),
                ElevatedButton(
                 onPressed: () { },
                 child: const Text("REGISTER"))
          ],
        ),
      ),
    );
  }
}
