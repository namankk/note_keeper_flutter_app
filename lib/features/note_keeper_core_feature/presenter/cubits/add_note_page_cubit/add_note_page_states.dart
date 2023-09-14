abstract class AddNotePageStates {}

class AddNotePageLoadingState extends AddNotePageStates {}

class AddNotePageLoadingDoneState extends AddNotePageStates {}

class AddNotePageInitialState extends AddNotePageStates {}

class AddNotePageErrorState extends AddNotePageStates {
  final String _message;

  AddNotePageErrorState(this._message);

  String get message => _message;
}

class AddNotePageSaveButtonTappedState extends AddNotePageStates {}

