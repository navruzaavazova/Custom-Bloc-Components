part of 'note_bloc.dart';

abstract class NoteState{
   const NoteState();
}

class NotesInitial extends NoteState {}
class NotesLoading extends NoteState {}
class NotesLoaded extends NoteState {
  final List<NoteModel> notes;
  const NotesLoaded(this.notes);

}
class NotesError extends NoteState {
  final String message;
  const NotesError(this.message);
}


class NoteInitial extends NoteState{}
class NoteSaving extends NoteState {}
class NoteSaved extends NoteState {}
