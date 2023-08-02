import 'package:bloc/bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_states.dart';

import '../../../domain/use_cases/show_list_use_case.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  final ShowListUseCase _showListUseCase;
  int count = 0;

  HomePageCubit(this._showListUseCase) : super(HomePageLoadingStates());

  void onInitializeEvent() async {
    final value = await _showListUseCase.showListOfNotes();
    value.fold((l) => emit(HomePageErrorStates(l.errorTitle)), (r) {
      if (r.isNotEmpty) {
        emit(HomePageSuccessStates(r));
      } else {
        emit(HomePageEmptyStates("List is Empty"));
      }
    });
  }

  void onTileTappedEvent() {
    emit(HomePageShowSnakeBar());
  }

  void onDeleteTappedEvent(int id) async {
    await _showListUseCase.deleteElements(id);
    final value = await _showListUseCase.showListOfNotes();
    value.fold((l) => emit(HomePageErrorStates(l.errorTitle)), (r) {
      if (r.isNotEmpty) {
        emit(HomePageSuccessStates(r));
      } else {
        emit(HomePageEmptyStates("List is Empty"));
      }
    });
  }
}
