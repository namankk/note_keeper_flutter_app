import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "noteKeeper.db";
  static final DatabaseHelper instance=DatabaseHelper._();
  factory DatabaseHelper(){
   return instance;
  }
  DatabaseHelper._();

  static Future<Database> _getDb() async {
    return openDatabase(path.join(await getDatabasesPath(), _dbName),
        version: _version,
        onCreate: (db, ver) => db.execute(
            "CREATE TABLE NoteKeeper(id INTEGER PRIMARY KEY, title TEXT NOT NULL, priority TEXT NOT NULL, date TEXT NOT NULL,description TEXT NOT NULL)"));
  }

  static Future<int> addNote(NoteModel noteModel)async{
    final db= await _getDb();
   return await db.insert("NoteKeeper", noteModel.toJson());
  }

  static Future<List<Map<String,dynamic>>> getAllNotes()async{
    final db=await _getDb();
    final map=await db.query("NoteKeeper");
    print(map);
    return map;
  }
}
