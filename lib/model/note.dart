import 'package:note_app/utils/color_combination.dart';

class Note {
  final int? id;
  final String heading;
  final String content;
  final DateTime lastEdit;
  final int primary;
  final int secondary;

  const Note(
      {this.id,
      required this.heading,
      required this.content,
      required this.lastEdit,
      required this.primary, required this.secondary,
      });

  Map<String, dynamic> toMap() {
    return {
      'title': heading,
      'text': content,
      'primaryColor': primary.toString(),
      'secondaryColor': secondary.toString()
    };
  }
  Note.fromJson(Map<String, dynamic> json)
      : heading = json['title'],
        content = json['text'],
        id = json['id'],
        primary = ColorCombination.colorCombinations[2]['primary']!,
        secondary = ColorCombination.colorCombinations[2]['secondary']!,
        lastEdit = DateTime.parse(json['updated_at'] as String);

  @override
  String toString() {
    return 'Note{id: $id, heading: $heading, content: $content, lastEdit: $lastEdit, primary: $primary, secondary: $secondary}';
  }
}
