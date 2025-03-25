import 'package:apple_notes_clone/presentation/screens/main_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'dependency_injection.dart';
import 'presentation/bloc/note_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.config();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<NoteCubit>()..fetchNotes(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreens(),
      ),
    );
  }
}
