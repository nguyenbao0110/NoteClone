
import '../../domain/entity/note.dart';

abstract class NoteRepository {
  Future<void> addNote(Note note);
  Future<List<Note>> getNotes();
  Future<void> deleteNote(String id);
}
