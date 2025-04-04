import '../repositories/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(String noteId) {
    return repository.deleteNote(noteId);
  }
}
