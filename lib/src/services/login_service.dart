import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/src/constants/constans.dart';
import 'package:test/src/pages/home.dart';

class LoginService {
  static Future login(context, username, password) async {
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    await http
        .post(
      Uri.parse(Constants.APIURL + "/api/login/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(map),
    )
        .then((response) async {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        print(json.decode(response.body)['error']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['error'].toString()),
          backgroundColor: Colors.red,
        ));
      }
    }).catchError((error) {
      if (error.runtimeType.toString() == 'SocketException') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verifica tu conexión.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
