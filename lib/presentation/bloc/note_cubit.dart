import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_state.dart';
import '../../domain/entity/note.dart';
import '../../domain/use_case/add_note_usecase.dart';
import '../../domain/use_case/get_notes_usecase.dart';
import '../../domain/use_case/delete_note_usecase.dart'; // Thêm use case để xóa ghi chú

class NoteCubit extends Cubit<NoteState> {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase; // Thêm use case để xóa

  NoteCubit(this.getNotesUseCase, this.addNoteUseCase, this.deleteNoteUseCase) : super(NoteInitial()) {
    fetchNotes(); // Gọi fetchNotes() ngay khi khởi tạo Cubit
  }

  void fetchNotes() async {
    emit(NoteLoading());
    try {
      final notes = await getNotesUseCase();
      print("✅ Notes fetched successfully: $notes"); // Debug log
      emit(NoteLoaded(notes));
    } catch (e, stacktrace) {
      print("❌ Error fetching notes: $e");
      print(stacktrace);
      emit(NoteError("Failed to load notes: ${e.toString()}"));
    }
  }

  void addNote(Note note) async {
    try {
      await addNoteUseCase(note);
      print("✅ Note added: ${note.title}");
      fetchNotes(); // Lấy lại danh sách sau khi thêm
    } catch (e) {
      print("❌ Error adding note: $e");
      emit(NoteError("Failed to add note: ${e.toString()}"));
    }
  }

  void deleteNote(String noteId) async { // Thay vì index, dùng id để xóa từ Firebase
    try {
      await deleteNoteUseCase(noteId);
      print("✅ Note deleted: $noteId");
      fetchNotes(); // Lấy lại danh sách sau khi xóa
    } catch (e) {
      print("❌ Error deleting note: $e");
      emit(NoteError("Failed to delete note: ${e.toString()}"));
    }
  }
}
