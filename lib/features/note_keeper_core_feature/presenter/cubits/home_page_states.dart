
import 'package:equatable/equatable.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

abstract class HomePageStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomePageEmptyStates extends HomePageStates {
  final String message;

  HomePageEmptyStates(this.message);

  @override
  List<Object?> get props => [message];
}

class HomePageLoadingStates extends HomePageStates {}

class HomePageErrorStates extends HomePageStates {
  final String message;

  HomePageErrorStates(this.message);

  @override
  List<Object?> get props => [message];
}

class HomePageSuccessStates extends HomePageStates {
  final List<NoteEntity> data;

  HomePageSuccessStates(this.data);

  @override
  List<Object?> get props => [data];
}
class HomePageShowSnakeBar extends HomePageStates implements Equatable {
  @override
  List<Object?> get props => [];
}

