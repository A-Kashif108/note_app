import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/note/note_bloc.dart';
import 'package:note_app/screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NoteBloc(),
      child: MaterialApp(
        title: 'Note App',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

