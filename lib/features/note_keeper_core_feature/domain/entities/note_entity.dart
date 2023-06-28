import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? _id;
  final String _title;
  final String _priority;
  final String _date;
  final String _description;

  const NoteEntity(
      {required int? id,
        required String title,
      required String priority,
      required String date,
      required String description})
      : _title = title,
          _id=id,
        _date=date,
        _priority = priority,
        _description = description;


  @override
  List<Object?> get props => [_title, _description, _priority,_date,_id];

  String get title => _title;

  String get priority => _priority;

  String get description => _description;

  String get date => _date;

  int? get id => _id;


}
