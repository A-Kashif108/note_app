import 'dart:convert';

import 'package:note_app/model/note.dart';
import 'package:http/http.dart' as http;

import 'local_storage_service.dart';

class NoteService {
  Future<List<Note>> getNotes(String username) async {
    final notes = await http.get(
        Uri.parse('https://nanonish.pythonanywhere.com/notes/${LocalStorage.getUsername()}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
    final jsonList = jsonDecode(notes.body) as List;

    List<Note> noteList = jsonList
        .map(
          (e) => Note.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return noteList;
  }

  Future<void> deleteNote(String id) async {
    await http.delete(Uri.parse('https://nanonish.pythonanywhere.com/notes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
  }

  Future<void> pinNote(String id,bool isPin) async {
    await http.patch(
      Uri.parse('https://nanonish.pythonanywhere.com/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, bool>{
        "isPin": isPin
      }),
    ).then((value) => print('error is : ${value.toString()}'));
  }

  Future<http.Response> postNote(String title, String text) async {
    final response = await http.post(
      Uri.parse('https://nanonish.pythonanywhere.com/notes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"author": LocalStorage.getUsername(), "title": title, "text": text}),
    );
    return response;
  }

  Future<void> updateNote(String id, String title, String text) async {
    await http.patch(
      Uri.parse('https://nanonish.pythonanywhere.com/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8'
      },
      body: jsonEncode(<String, String>{
        "title": title,
        "text": text,
      }),
    );
  }
}
