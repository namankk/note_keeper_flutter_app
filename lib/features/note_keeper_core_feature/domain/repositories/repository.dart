import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

import '../../../../../core/core_models/success_core.dart';

abstract class RepositoryBase{
  Future<Either<ErrorCore,List<NoteEntity>>> getListOfNote();
  Stream<List<NoteEntity>> getListOfNoteStreams();
  Future<Either<ErrorCore,SuccessCore>> addEntity(NoteEntity noteEntity);
  Future<Either<ErrorCore,SuccessCore>> updateEntity(NoteEntity noteEntity);
  Future<Either<ErrorCore,SuccessCore>> deleteEntity(int id);
}