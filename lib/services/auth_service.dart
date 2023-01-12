import 'dart:convert';

import 'package:note_app/model/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> login(User user) async {
    final response = await http.post(
        Uri.parse('http://nanonish.pythonanywhere.com/users/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "username": user.username!,
            "password": user.password!,
          },
        ));
    return response;
  }

  Future<void> signup(User user) async {
    final response = await http.post(
      Uri.parse('http://nanonish.pythonanywhere.com/users/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "username": user.username!,
          "password": user.password!,
        },
      ),
    );
  }
}
