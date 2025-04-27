import 'package:bloc/bloc.dart';
import 'package:state_using_stream/presentation/note/database/note_database_repo.dart';
import 'package:state_using_stream/presentation/note/models/note_model.dart';
import 'package:state_using_stream/base/transformer/restartable_auto_save.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabaseRepo _noteDatabaseRepo = NoteDatabaseRepo();
  NoteBloc() : super(NotesInitial()) {
    on<CreateNote>(_createNote);
    on<AutoSaveNote>(
      _autoSaveNote,
      transformer: restartableAutoSave(
        const Duration(seconds: 4),
      ),
    );
    on<SaveNote>(_saveNote);
    on<GetNotes>(_getNotes);
  }

  Future<void> _autoSaveNote(
      AutoSaveNote event, Emitter<NoteState> emit) async {
    emit(NoteSaving());
    await _noteDatabaseRepo.saveNote(event.note);
    emit(NoteSaved());
  }

  Future<void> _saveNote(SaveNote event, Emitter<NoteState> emit) async {
    await _noteDatabaseRepo.saveNote(event.note);
    add(GetNotes());
  }

  Future<void> _createNote(CreateNote event, Emitter<NoteState> emit) async {
    await _noteDatabaseRepo.createNote(event.note);
    add(GetNotes());
  }

  Future<void> _getNotes(GetNotes event, Emitter<NoteState> emit) async {
    emit(NotesLoading());
    final notes = await _noteDatabaseRepo.getAllNotes();
    emit(NotesLoaded(notes));
  }
}
