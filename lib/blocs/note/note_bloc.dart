import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/database/sql_database.dart';
import 'package:note_app/model/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final SQLiteDatabase _db = SQLiteDatabase();
  NoteBloc() : super(NoteInitial()) {
    on<GetAllNotes>((event, emit) async {
      emit(NoteLoading());
      List<Note> notes = await _db.notes();
      emit(NoteLoaded(notes));
    });
    on<AddEvent>((event, emit) {
      emit(CreateNote());
    });

    on<InsertNote>((event, emit) async {
      emit(NoteLoading());
      await _db.insertNote(event.note);
      List<Note> notes = await _db.notes();
      emit(NoteLoaded(notes));
    });
    on<NoteViewEvent>((event, emit) {
      emit(NoteView(event.note));
    });
    on<UpdateNote>((event, emit) async {
      emit(NoteLoading());
      await _db.updateNote(event.note);
      List<Note> notes = await _db.notes();
      emit(NoteLoaded(notes));
    });
    on<DeleteNote>((event, emit) async {
      emit(NoteLoading());
      await _db.deleteNote(event.id);
      List<Note> notes = await _db.notes();
      emit(NoteLoaded(notes));
    });
  }
}
