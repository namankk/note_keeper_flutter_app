import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel(
      {required super.id,
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "priority": priority,
        "date": date,
        "description": description
      };
}
