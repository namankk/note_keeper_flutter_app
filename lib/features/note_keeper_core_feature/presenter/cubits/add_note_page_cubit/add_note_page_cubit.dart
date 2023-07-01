import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_states.dart';

import '../../../../../core/helper/database_helper.dart';

class AddNotePageCubit extends Cubit<AddNotePageStates> {
  AddNotePageCubit() : super(AddNotePageInitialState());

  void mapEventsWithStates(AddNotePageEvent event) {
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
        break;
      case AddNotePageEvent.onCloseButtonScreenEvent:
        emit(AddNotePageCloseButtonTappedState());
        break;
    }
  }

  void addNote(NoteModel noteModel) async {
    await DatabaseHelper.addNote(noteModel);
    emit(AddNotePageSaveButtonTappedState());
  }
}
