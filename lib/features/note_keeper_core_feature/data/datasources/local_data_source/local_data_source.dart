import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/core_models/error_core.dart';
import 'package:note_keeper_flutter_app/core/helper/database_helper.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source_base.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core_models/success_core.dart';

class LocalDataSource extends LocalDataSourceBase {
  final DatabaseHelper _databaseHelper;

  LocalDataSource(this._databaseHelper);

  final _streamController=BehaviorSubject<List<NoteModel>>();
  @override
  Future<Either<ErrorCore, SuccessCore>> addNote(NoteModel noteModel) async {
    try {
      await _databaseHelper.addNote(noteModel);

      _streamController.add([..._streamController.value,noteModel]);
      return Right(SuccessCore());
    } catch (e) {
      return Left(ErrorCore(errorTitle: "Error in Adding note", errorDescription: e.toString()));
    }
  }

  @override
  Future<Either<ErrorCore, List<NoteModel>>> getAllNotes() async {
    try {
      final data = await _databaseHelper.getAllNotes();
      List<NoteModel> listOfModel =
          List.from(data).map((e) => NoteModel.fromJson(e)).toList();
      _streamController.add(listOfModel);
      return Right(listOfModel);
    } catch (exception) {
      return Left(ErrorCore(
          errorTitle: "Something went wrong",
          errorDescription: exception.toString()));
    }
  }

  @override
  Future<Either<ErrorCore, SuccessCore>> deleteNote(int id) async {
    try {
      await _databaseHelper.deleteNote(id);
      NoteModel m=_streamController.value.firstWhere((element) => element.id==id);
      _streamController.value.remove(m);
      return Right(SuccessCore());
    } catch (e) {
      return Left(ErrorCore(
          errorTitle: "Something went wrong", errorDescription: e.toString()));
    }
  }

  @override
  Stream<List<NoteModel>> getAllNotesStream(){
    return _streamController.asBroadcastStream();
  }
}
