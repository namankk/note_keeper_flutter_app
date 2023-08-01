import 'package:flutter/material.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

Widget noteTileWidget(NoteEntity noteEntity){
 return Card(
    child: Row(
      children: [
        Container(decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),child: Text(noteEntity.priority),),
        Expanded(child: Text("${noteEntity.title}")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.delete),
        ),
      ],
    ),
  );
}