import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apple_notes_clone/presentation/bloc/note_cubit.dart';
import 'package:apple_notes_clone/presentation/bloc/note_state.dart';
import 'package:apple_notes_clone/presentation/widgets/item_widget.dart';
import 'package:apple_notes_clone/domain/entity/note.dart';

class HomeScreenEmpty extends StatelessWidget {
  const HomeScreenEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return state.notes.isEmpty
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    "https://i.pinimg.com/736x/39/3e/c9/393ec92df9118ae7a4bbf0e7f9e17c0f.jpg",
                    height: 250,
                    width: 250,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 50);
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create your first note!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
                : ItemsWidget(
              notes: state.notes,
              onDelete: (noteId) {
                context.read<NoteCubit>().deleteNote(noteId.toString());
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          // Thêm ghi chú mới
          final newNote = Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: "New Note",
            content: "Content",
            remindAt: DateTime.now().add(const Duration(days: 1)),
            color: Colors.yellowAccent.value, // Thêm màu mặc định
          );


          context.read<NoteCubit>().addNote(newNote);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
