import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late LocalStorage _instance;
  static late SharedPreferences _preferences;

  static Future<LocalStorage> getInstance() async {
    _instance = LocalStorage();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  static String getUsername() {
    return _preferences.getString('username') ?? '';
  }

  static void setUsername(String username) {
    _preferences.setString('username', username);
  }
}
