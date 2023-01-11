part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class GetAllNotes extends NoteEvent {}

class OpenNote extends NoteEvent {
  final Note note;

  OpenNote(this.note);
}

class AddEvent extends NoteEvent {}

class InsertNote extends NoteEvent {
  final Note note;

  InsertNote(this.note);
}

class NoteViewEvent extends NoteEvent {
  final Note note;

  NoteViewEvent(this.note);
}

class UpdateNote extends NoteEvent {
  final Note note;

  UpdateNote(this.note);
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);
}
