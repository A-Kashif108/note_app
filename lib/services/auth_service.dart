import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_app/services/local_storage_service.dart';

class AuthService {
  Future<int> signIn(String username, String password) async {
    final response = await http.post(
        Uri.parse('http://nanonish.pythonanywhere.com/users/signin/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "username": username,
            "password": password,
          },
        ));
    return response.statusCode;
  }

  Future<int> signUp(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://nanonish.pythonanywhere.com/users/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "username": username,
          "password": password,
        },
      ),
    );
    return response.statusCode;
  }
}
