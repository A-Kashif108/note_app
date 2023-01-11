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
      'heading': heading,
      'content': content,
      'lastEdit': lastEdit.toIso8601String(),
      'primaryColor': primary.toString(),
      'secondaryColor': secondary.toString()
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, heading: $heading, content: $content, lastEdit: $lastEdit, primary: $primary, secondary: $secondary}';
  }
}
