import 'package:flutter/material.dart';
import 'package:test/src/utils/globals.dart';
import 'package:test/src/utils/shared_preferences.dart';

class LoginService {
  static Future<bool> login(context, String user, String pass) {
    bool logged = false;
    String prefPass = SharedPreferencesGlobal.prefs.getString(user) ?? '';
    if (pass == prefPass) {
      logged = true;
      Globals.user = user;
      Globals.isAdmin = (user == "admin");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Credenciales incorrectas"),
        backgroundColor: Colors.red,
      ));
    }
    return Future.value(logged);
  }
}
