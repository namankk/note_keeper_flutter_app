import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/show_list_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_bloc/home_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_bloc/home_page_states.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageStates> {
  final ShowListUseCase _showListUseCase;

  HomePageBloc(this._showListUseCase) : super(HomePageEmptyStates()) {
    on<OnPageInitialized>((event, emit) async {
      emit(HomePageLoadingStates());
      await _showListUseCase.showListOfNotes();
      await emit.forEach(_showListUseCase.showStreamOfNotes(),
          onData: (data) => data.isEmpty
              ? HomePageEmptyStates()
              : HomePageSuccessStates(data),
          onError: (_, a) => HomePageErrorStates());
    });
    on<OnDeleteButtonTap>((event, emit) async {
      final response = await _showListUseCase.deleteElements(event.id);
      response.fold((l) => emit(HomePageEmptyFilterStates()), (r) {});
    });
    on<OnSearchChange>((event, emit) async {
      await emit.forEach(_showListUseCase.showStreamOfNotes(),
          onData: (data) {
            if (data.isEmpty) {
              return HomePageEmptyStates();
            }
            var newData = data
                .where((element) =>
                    element.title.toLowerCase().contains(
                        event.searchString.toString().toLowerCase()) ||
                    element.description
                        .toLowerCase()
                        .contains(event.searchString.toString().toLowerCase()))
                .toList();
            return newData.isEmpty
                ? HomePageEmptyFilterStates()
                : HomePageSuccessStates(newData);
          },
          onError: (_, a) => HomePageErrorStates());
    });
  }
}
