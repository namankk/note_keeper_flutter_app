import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/repository/Repository.dart';

class ShowListUseCase{
  RepositoryBase _repositoryBase;

  ShowListUseCase(this._repositoryBase);

  Future<Either<ErrorCore,List<NoteEntity>>> showListOfNotes()async{
    return await _repositoryBase.getListOfNote();
  }

}