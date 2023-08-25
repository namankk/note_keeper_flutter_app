import 'package:flutter/material.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

@immutable
sealed class HomePageStates{}

class HomePageLoadingStates extends HomePageStates{}

class HomePageEmptyStates extends HomePageStates{}

class HomePageErrorStates extends HomePageStates{}

class HomePageSuccessStates extends HomePageStates{
  final List<NoteEntity> data;

  HomePageSuccessStates(this.data);
}