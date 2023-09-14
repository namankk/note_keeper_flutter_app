import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';

import '../../../../../core/core_models/success_core.dart';


abstract class LocalDataSourceBase{
  Future<Either<ErrorCore,List<NoteModel>>> getAllNotes();
  Future<Either<ErrorCore,SuccessCore>> addNote(NoteModel noteModel);
  Future<Either<ErrorCore,SuccessCore>> updateNote(NoteModel noteModel);
  Future<Either<ErrorCore,SuccessCore>> deleteNote(int id);
  Stream<List<NoteModel>> getAllNotesStream();
}