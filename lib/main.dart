import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/core/routes/routes.dart';
import 'package:note_keeper_flutter_app/core/utils/app_color.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/drop_down_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_bloc/home_page_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_cubit.dart';

import 'package:note_keeper_flutter_app/core/service_locator/service_locator.dart'
    as serviceLocator;

void main() {
  serviceLocator.setUp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => serviceLocator.sl<NoteDetailPageCubit>()),
    BlocProvider(create: (context) => serviceLocator.sl<HomePageBloc>()),
    BlocProvider(create: (context) => serviceLocator.sl<DropDownCubit>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoteKeeper App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.addNoteColor, brightness: Brightness.light),
        useMaterial3: true,
      ),
      routerConfig: goRoute,
    );
  }
}
