import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel(
      {super.id,
      required super.title,
      required super.priority,
      required super.date,
      required super.description});

  factory NoteModel.fromJson(Map<String, dynamic> jsonMap) {

    return NoteModel(
        id: jsonMap["id"],
        title: jsonMap["title"],
        priority: jsonMap["priority"],
        date: jsonMap["date"],
        description: jsonMap["description"]);
  }

  NoteModel copyWith(
      {int? id,
      String? title,
      String? priority,
      String? date,
      String? description}) {
    return NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        priority: priority ?? this.priority,
        date: date ?? this.date,
        description: description ?? this.description);
  }

  Map<String, dynamic> toJson() => {
        // "id": id,
        "title": title,
        "priority": priority,
        "date": date,
        "description": description
      };
}
