import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

import '../../../../../core/core_models/success_core.dart';
import '../repositories/repository.dart';

class ShowListUseCase {
  final RepositoryBase _repositoryBase;

  ShowListUseCase(this._repositoryBase);

  Future<Either<ErrorCore, List<NoteEntity>>> showListOfNotes() async {
    return await _repositoryBase.getListOfNote();
  }

  Future<Either<ErrorCore, SuccessCore>> deleteElements(int id) async {
    return await _repositoryBase.deleteEntity(id);
  }
}
