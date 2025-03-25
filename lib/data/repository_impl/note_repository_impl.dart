import 'package:firebase_database/firebase_database.dart';
import '../../data/model/note_model.dart';
import '../../domain/entity/note.dart';
import '../../domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final FirebaseDatabase database; // Nhận FirebaseDatabase thay vì Firestore
  final DatabaseReference _db;

  NoteRepositoryImpl(this.database) : _db = database.ref('notes'); // Khởi tạo ref

  @override
  Future<void> addNote(Note note) async {
    await _db.child(note.id).set(NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      remindAt: note.remindAt,
      color: note.color
    ).toJson());
  }

  @override
  Future<List<Note>> getNotes() async {
    final snapshot = await _db.get();
    if (snapshot.exists) {
      List<Note> notes = [];
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        notes.add(NoteModel.fromJson(Map<String, dynamic>.from(value)));
      });
      return notes;
    }
    return [];
  }

  @override
  Future<void> deleteNote(String id) async {
    await _db.child(id).remove();
  }
}

