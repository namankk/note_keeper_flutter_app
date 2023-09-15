import 'dart:ui';

import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? _id;
  final String _title;
  final String _date;
  final String _description;
  Color? _color;

  NoteEntity(
      {required int? id,
      required String title,
      required String date,
      required String description,
      Color? color})
      : _title = title,
        _id = id,
        _date = date,
        _description = description,
        _color = null;

  @override
  List<Object?> get props => [_title, _description, _date, _id];

  String get title => _title;


  String get description => _description;

  String get date => _date;

  int? get id => _id;

  Color get color => _color!;

  set setColor(Color value) {
    _color = value;
  }
}
