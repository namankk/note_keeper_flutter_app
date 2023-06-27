import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String _title;
  final String _priority;
  final String _description;

  NoteEntity(
      {required String title,
      required String priority,
      required String description})
      : _title = title,
        _priority = priority,
        _description = description;

  @override
  List<Object?> get props => [_title, _description, _priority];

  get title => _title;

  get priority => _priority;

  get description => _description;
}
