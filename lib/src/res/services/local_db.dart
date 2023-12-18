import 'package:isar/isar.dart';
import 'package:notesbucket/src/res/model/note.dart';

class LocalDBServices {
  late Future<Isar> db;

  LocalDBServices() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([NoteSchema], inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  //Function to add note inside the localDB
  Future<void> saveNote({required Note note}) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.putSync(note));
  }

  //Function to display all the notes in the database
  Stream<List<Note>> listenAllNotes() async* {
    final isar = await db;
    yield* isar.notes.where().watch(fireImmediately: true);
  }

  //Function to delete id from the collections
  void deleteNote({required int id}) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.deleteSync(id));
  }
}
