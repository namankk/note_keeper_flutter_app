import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/core/routes/routes.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/repository_impl/repository_impl.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/show_list_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/drop_down_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_cubit.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          HomePageCubit(ShowListUseCase(RepositoryImpl(LocalDataSource())))
            ..mapEventWithStates(HomePageEvents.onInitializeScreen),
    ),
    BlocProvider(create: (context) => NoteDetailPageCubit()),
    // BlocProvider(create: (context) => AddNotePageCubit()),
    BlocProvider(create: (context) => DropDownCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoteKeeper App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: goRoute,
    );
  }
}
