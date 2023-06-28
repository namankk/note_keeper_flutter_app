import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/core/SuccessCore.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';

abstract class LocalDataSourceBase{
  Future<Either<ErrorCore,List<NoteModel>>> getAllNotes();
  Future<Either<ErrorCore,SuccessCore>> addNote();
}