import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/core/SuccessCore.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

abstract class RepositoryBase{
  Future<Either<ErrorCore,List<NoteEntity>>> getListOfNote();
  Future<Either<ErrorCore,SuccessCore>> updateEntity(NoteEntity noteEntity);
  Future<Either<ErrorCore,SuccessCore>> deleteEntity(int id);
}