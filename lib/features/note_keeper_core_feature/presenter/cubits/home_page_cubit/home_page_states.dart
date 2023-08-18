import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

abstract class HomePageStates {}

class HomePageEmptyStates extends HomePageStates {
  final String _message;

  HomePageEmptyStates(this._message);

  String get message => _message;
}

class HomePageLoadingStates extends HomePageStates {}

class HomePageErrorStates extends HomePageStates {
  final String _message;

  HomePageErrorStates(this._message);

  String get message => _message;
}

class HomePageSuccessStates extends HomePageStates {
  final List<NoteEntity> _data;
  HomePageSuccessStates(this._data);

  List<NoteEntity> get data => _data;
}

class HomePageShowSnakeBar extends HomePageStates {}
