import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/core/SuccessCore.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source_base.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/repository/Repository.dart';

class RepositoryImpl implements RepositoryBase{
  final LocalDataSourceBase _localDataSourceBase;

  RepositoryImpl(this._localDataSourceBase);

  @override
  Future<Either<ErrorCore, List<NoteEntity>>> getListOfNote() async{
     return await _localDataSourceBase.getAllNotes();
  }

  @override
  Future<Either<ErrorCore, SuccessCore>> updateEntity(NoteEntity noteEntity) {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }

}