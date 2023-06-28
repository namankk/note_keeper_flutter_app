
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/repository_impl/repository_impl.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/show_list_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HomePageCubit(ShowListUseCase(RepositoryImpl(LocalDataSource())))..mapEventWithStates(HomePageEvents.onInitializeScreen),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
