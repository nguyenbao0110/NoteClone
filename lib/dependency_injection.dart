import 'package:apple_notes_clone/domain/repositories/note_repository.dart';
import 'package:apple_notes_clone/presentation/bloc/note_cubit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'data/repository_impl/note_repository_impl.dart';
import 'domain/use_case/add_note_usecase.dart';
import 'domain/use_case/delete_note_usecase.dart';
import 'domain/use_case/get_notes_usecase.dart';

class DependencyInjection {
  final getIt = GetIt.instance;

  DependencyInjection.config() {
    //Đăng ký firebase
    getIt.registerLazySingleton<FirebaseDatabase>(
        () => FirebaseDatabase.instance);
    getIt.registerLazySingleton<NoteRepository>(
        () => NoteRepositoryImpl(getIt<FirebaseDatabase>()));

    // Đăng ký các UseCase
    getIt.registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(getIt<NoteRepository>()),
    );

    getIt.registerLazySingleton<AddNoteUseCase>(
      () => AddNoteUseCase(getIt<NoteRepository>()),
    );
    getIt.registerLazySingleton<DeleteNoteUseCase>(
        () => DeleteNoteUseCase(getIt<NoteRepository>()));

    // Đăng ký NoteCubit
    getIt.registerLazySingleton(() => NoteCubit(
          getIt<GetNotesUseCase>(),
          getIt<AddNoteUseCase>(),
          getIt<DeleteNoteUseCase>(),
        ));
  }
}
