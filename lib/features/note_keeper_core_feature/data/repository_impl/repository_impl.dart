import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/core/SuccessCore.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/repository/Repository.dart';

class RepositoryImpl implements RepositoryBase{
  @override
  Future<Either<ErrorCore, List<NoteEntity>>> getListOfNote() async{
     await Future.delayed(const Duration(seconds: 3));
     return Right([NoteEntity(title: "dummy title", priority: "P1", description: "dummy description")]);
  }

  @override
  Future<Either<ErrorCore, SuccessCore>> updateEntity(NoteEntity noteEntity) {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }

}