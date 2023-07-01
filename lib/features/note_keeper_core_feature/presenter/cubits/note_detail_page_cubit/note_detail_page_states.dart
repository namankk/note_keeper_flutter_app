import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

abstract class NoteDetailPageStates {}

class NoteDetailPageLoadingState extends NoteDetailPageStates {}

class NoteDetailPageLoadingDoneState extends NoteDetailPageStates {}

class NoteDetailPageInitialState extends NoteDetailPageStates {
  final NoteEntity _noteEntity;

  NoteDetailPageInitialState(this._noteEntity);

  NoteEntity get noteEntity => _noteEntity;
}

class NoteDetailPageErrorState extends NoteDetailPageStates {
  final String _message;

  NoteDetailPageErrorState(this._message);

  String get message => _message;
}

class NoteDetailPageSaveButtonTappedState extends NoteDetailPageStates {}

class NoteDetailPageCloseButtonTappedState extends NoteDetailPageStates {}
