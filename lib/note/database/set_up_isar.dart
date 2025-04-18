
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:state_using_stream/note/models/note_model.dart';

class SetUpIsar {
  static late final Isar db;
  static Future<void> setUp() async {
    final appDir = await getApplicationDocumentsDirectory();
    db = await Isar.open([NoteModelSchema],
    directory: appDir.path);
  }
}