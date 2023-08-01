import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/add_note_use_case.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_states.dart';

import '../../../domain/entities/note_entity.dart';

class AddNotePageCubit extends Cubit<AddNotePageStates> {
  final AddNoteUseCase _addNoteUseCase;
  AddNotePageCubit(this._addNoteUseCase) : super(AddNotePageInitialState());
  void mapEventsWithStates(AddNotePageEvent event,{NoteEntity? noteEntity}) {
    switch (event) {
      case AddNotePageEvent.onInitialScreenEvent:
        emit(AddNotePageInitialState());
        break;
      case AddNotePageEvent.onLoadingScreenEvent:
        emit(AddNotePageLoadingState());
        break;
      case AddNotePageEvent.onErrorScreenEvent:
        emit(AddNotePageErrorState("Something went wrong"));
        break;
      case AddNotePageEvent.onSaveButtonScreenEvent:
        addNote(noteEntity!);
        break;
      case AddNotePageEvent.onCloseButtonScreenEvent:
        emit(AddNotePageCloseButtonTappedState());
        break;
    }
  }

  void addNote(NoteEntity noteEntity) async {
    await _addNoteUseCase.saveNote(noteEntity);
    emit(AddNotePageSaveButtonTappedState());
  }
}
