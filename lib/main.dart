import 'package:flutter/material.dart';
import 'package:note_app/screens/login_page.dart';
import 'package:note_app/services/local_storage_service.dart';
import 'package:note_app/screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LocalStorage.getUsername() == ''
          ? const LoginViewPage()
          : const HomePage(),
    );
  }
}
