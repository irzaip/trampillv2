import 'package:flutter/cupertino.dart';
import 'httpapi.dart';

enum LoginStatusState { notloggedin, loggedin, error, expire }

class LoginState with ChangeNotifier {
  LoginStatusState state = LoginStatusState.notloggedin;
  //var username;
  String errorMessage = "";
  String _status = "undefined";
  late bool loggedin;

  login() async {
    loggedin = await relogin();

    if (loggedin == true) {
      state = LoginStatusState.loggedin;
      _status = "logged in";
      notifyListeners();
    } else {
      state = LoginStatusState.notloggedin;
      _status = "failed login";
      notifyListeners();
    }
  }

  set loo(String value) {
    _status = value;
  }

  void tulis(String value) {
    _status = value;
    notifyListeners();
  }

  String get status => _status;
}
