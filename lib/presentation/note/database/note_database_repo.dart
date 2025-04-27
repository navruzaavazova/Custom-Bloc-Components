import 'package:isar/isar.dart';
import 'package:state_using_stream/presentation/note/database/set_up_isar.dart';
import 'package:state_using_stream/presentation/note/models/note_model.dart';

class NoteDatabaseRepo {
  final _isar = SetUpIsar.db;

  Future<void> createNote(NoteModel note) async {
  await _isar.writeTxn(() async {
    await _isar.noteModels.put(note);
  });
}

  Future<void> saveNote(NoteModel note) async {
    await _isar.writeTxn(() async {
      note.updatedAt = DateTime.now();
      await _isar.noteModels.put(note);
    });
  }
  Future<List<NoteModel>> getAllNotes() async {
  return await _isar.noteModels.where().findAll();
}

}
