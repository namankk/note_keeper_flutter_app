import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source_base.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

import '../../../../../core/core_models/success_core.dart';
import '../../domain/repositories/repository.dart';


class RepositoryImpl implements RepositoryBase{
  final LocalDataSourceBase _localDataSourceBase;

  RepositoryImpl(this._localDataSourceBase);

  @override
  Future<Either<ErrorCore, List<NoteEntity>>> getListOfNote() async{
     return await _localDataSourceBase.getAllNotes();
  }

  @override
  Future<Either<ErrorCore, SuccessCore>> updateEntity(NoteEntity noteEntity) async{
    return await _localDataSourceBase.addNote(noteEntity as NoteModel);
  }

  @override
  Future<Either<ErrorCore, SuccessCore>> deleteEntity(int id) async{
    return await _localDataSourceBase.deleteNote(id);
  }

  @override
  Stream<List<NoteEntity>> getListOfNoteStreams() {
    return _localDataSourceBase.getAllNotesStream();
  }

}