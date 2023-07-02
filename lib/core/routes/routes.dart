import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/pages/add_note_page.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/pages/home_page.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/pages/note_detail_page.dart';
final goRoute = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: "/",
      name: RouteNames.homePage,
      builder: (context, states) => const HomePage(),
      routes: [
        GoRoute(
            path: "add_note",
            name: RouteNames.addNote,
            builder: (context, states) => BlocProvider(create: (context)=>AddNotePageCubit(),
            child: const AddNotePage(),)),
        GoRoute(
            path: "note_details",
            name: RouteNames.noteDetails,
            builder: (context, states) => const NoteDetailPage("Note Details"))
      ]),
]);
