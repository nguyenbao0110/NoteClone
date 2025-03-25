import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/note_cubit.dart';
import '../bloc/note_state.dart';
import 'home_screen_empty.dart';
import 'note_creation_screen.dart';
import '../widgets/item_widget.dart';
import '../../domain/entity/note.dart';

class MainScreens extends StatelessWidget {
  const MainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<NoteCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            debugPrint("Current state: $state");

            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoteLoaded) {
              return state.notes.isEmpty
                  ? const HomeScreenEmpty()
                  : ItemsWidget(
                notes: state.notes,
                onDelete: (noteId) {
                  debugPrint("Deleting note with id: $noteId");
                  context.read<NoteCubit>().deleteNote(noteId.toString());
                },
              );
            } else if (state is NoteError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newNoteData = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NoteCreationScreen()),
            );

            if (newNoteData != null) {
              final newNote = Note(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: newNoteData['title'],
                content: newNoteData['content'],
                remindAt: DateTime.now().add(const Duration(days: 1)), // Ngày mai
                color: newNoteData['color'], // Lấy màu do người dùng chọn
              );

              debugPrint("Adding new note: $newNote");
              context.read<NoteCubit>().addNote(newNote);
            }
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
