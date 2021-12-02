import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  try {
                    loggedin = await sendlogin(fUsername, fPassword);

                    if (loggedin == true) {
                      prefs.setString("username", fUsername);
                      prefs.setString("password", fPassword);

                      Get.back(result: "success");
                    } else {
                        Get.snackbar(
                          "STATUS",
                          "Login gagal - userid atau password salah",
                          icon: Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          borderRadius: 20,
                          margin: EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
                          isDismissible: true,
                          dismissDirection: SnackDismissDirection.HORIZONTAL,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );

                    }
                  } catch (e) {
                        Get.snackbar(
                          "STATUS",
                          "Error Connecting server, please check internet",
                          icon: Icon(Icons.error, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          borderRadius: 20,
                          margin: EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
                          isDismissible: true,
                          dismissDirection: SnackDismissDirection.HORIZONTAL,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );

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
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: const Text("REGISTER"))
          ],
        ),
      ),
    );
  }
}
