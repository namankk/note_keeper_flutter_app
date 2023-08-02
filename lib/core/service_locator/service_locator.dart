import 'package:get_it/get_it.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/repository_impl/repository_impl.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/add_note_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/show_list_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_cubit.dart';

import '../../features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/drop_down_cubit.dart';
import '../../features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_cubit.dart';
import '../helper/database_helper.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(() => LocalDataSource(sl<DatabaseHelper>()));
  sl.registerLazySingleton(() => RepositoryImpl(sl<LocalDataSource>()));
  sl.registerFactory(() => AddNoteUseCase(sl<RepositoryImpl>()));
  sl.registerFactory(() => AddNotePageCubit(sl()));
  sl.registerFactory(() => DropDownCubit());
  sl.registerFactory(() => ShowListUseCase(sl<RepositoryImpl>()));
  sl.registerFactory(() => NoteDetailPageCubit());
  sl.registerFactory(() => HomePageCubit(sl())
    ..onInitializeEvent());
}
