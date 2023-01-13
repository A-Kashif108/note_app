import 'dart:convert';

import 'package:note_app/model/note.dart';
import 'package:http/http.dart' as http;

class NoteService {
  Future<List<Note>> getNotes(String username) async {
    final notes = await http.get(
        Uri.parse('http://10.0.2.2:8000/notes/testUser'),
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
    await http.delete(Uri.parse('http://10.0.2.2:8000/notes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
  }

  Future<void> pinNote(String id,bool isPin) async {
    await http.patch(
      Uri.parse('http://10.0.2.2:8000/notes/$id'),
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
      Uri.parse('http://10.0.2.2:8000/notes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"author": "testUser", "title": title, "text": text}),
    );
    return response;
  }

  Future<void> updateNote(String id, String title, String text) async {
    await http.patch(
      Uri.parse('http://10.0.2.2:8000/notes/$id'),
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
