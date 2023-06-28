import 'package:dartz/dartz.dart';
import 'package:note_keeper_flutter_app/core/ErrorCore.dart';
import 'package:note_keeper_flutter_app/core/SuccessCore.dart';
import 'package:note_keeper_flutter_app/core/helper/database_helper.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/datasources/local_data_source/local_data_source_base.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';

class LocalDataSource extends LocalDataSourceBase{

  @override
  Future<Either<ErrorCore, SuccessCore>> addNote() {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorCore, List<NoteModel>>> getAllNotes() async{
   try {
     final data= await DatabaseHelper.getAllNotes();
     List<NoteModel> listOfModel = List.from(data).map((e) =>
         NoteModel.fromJson(e)).toList();
     return Right(listOfModel);
   }catch(exception){
     return Left(ErrorCore(errorTitle: "Something went wrong", errorDescription:exception.toString()));
   }
  }



}