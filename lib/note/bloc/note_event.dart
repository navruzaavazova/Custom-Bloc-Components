part of 'note_bloc.dart';


abstract class NoteEvent {
  const NoteEvent();
}

class GetNotes extends NoteEvent {}

class CreateNote extends NoteEvent {
  final NoteModel note;
  const CreateNote(this.note);

}
class AutoSaveNote extends NoteEvent {
  final NoteModel note;
  const AutoSaveNote(this.note);
}

class SaveNote extends NoteEvent {
  final NoteModel note;
  const SaveNote(this.note);
}
