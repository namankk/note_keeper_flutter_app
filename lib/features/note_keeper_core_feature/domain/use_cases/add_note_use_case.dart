import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/core/core_models/success_core.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/repositories/repository.dart';

class AddNoteUseCase {
  final RepositoryBase _repositoryBase;

  AddNoteUseCase(this._repositoryBase);

  Future<Either<ErrorCore, SuccessCore>> saveNote(NoteEntity noteEntity) async {
    return await _repositoryBase.updateEntity(noteEntity);
  }
}
