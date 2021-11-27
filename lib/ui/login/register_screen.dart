import 'package:flutter/material.dart';
import 'package:trampillv2/api/httpapi.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loggedin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  @override
  void initState() {
    usernameController.text;
    emailController.text;
    passwordController.text;
    confirmpassController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',

                    errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                    // contentPadding: const EdgeInsets.only(
                    //     left: 10, right: 10, top: 10, bottom: 10)
                  ),
                  keyboardType: TextInputType.name,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'masukan username';
                    }
                  },
                  obscureText: false,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'masukan email';
                    }
                  },
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'masukan password';
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: confirmpassController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'ulangi password';
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ulangin passowrd',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        register(
                            usernameController.text,
                            emailController.text,
                            passwordController.text,
                            confirmpassController.text);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Register Berhasil."),
                        ));

                        Navigator.pop(
                          context,
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Register Error"),
                        ));
                      }
                    },
                    child: const Text('Daftar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
