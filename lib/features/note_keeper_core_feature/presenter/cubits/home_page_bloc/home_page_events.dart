import 'package:flutter/material.dart';

@immutable
sealed class HomePageEvents {}

class OnPageInitialized extends HomePageEvents {}

class OnAddNoteButtonTap extends HomePageEvents {}

class OnDeleteButtonTap extends HomePageEvents {
  final int _id;

  get id => _id;

  OnDeleteButtonTap(this._id);
}
