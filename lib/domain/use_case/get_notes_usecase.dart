import 'package:apple_notes_clone/domain/repositories/note_repository.dart';

import '../entity/note.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call() {
    return repository.getNotes();
  }
}
