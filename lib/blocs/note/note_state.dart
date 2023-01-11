part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);
}

class CreateNote extends NoteState {}

class NoteCreated extends NoteState {
  final Note note;

  NoteCreated(this.note);
}

class NoteView extends NoteState {
  final Note note;

  NoteView(this.note);
  
}
