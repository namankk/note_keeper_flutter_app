import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "noteKeeper.db";

  Future<Database> _getDb() async {
    return openDatabase(path.join(await getDatabasesPath(), _dbName),
        version: _version,
        onCreate: (db, ver) => db.execute(
            "CREATE TABLE NoteKeeper(id INTEGER PRIMARY KEY, title TEXT NOT NULL, date TEXT NOT NULL, description TEXT NOT NULL)"));
  }

   Future<int> addNote(NoteModel noteModel) async {
    final db = await _getDb();
    return await db.insert("NoteKeeper", noteModel.toJson());
  }

   Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await _getDb();
    final map = await db.query("NoteKeeper",orderBy: "id DESC");
    print(map);
    return map;
  }

   Future<int> deleteNote(int id) async {
    final db = await _getDb();
    return await db.delete("NoteKeeper", where: "id =?", whereArgs: [id]);
  }

  Future<int> updateNote(NoteModel noteModel) async {
    final db = await _getDb();
    return await db.update("NoteKeeper",noteModel.toJsonWithId(),where: "id =?", whereArgs: [noteModel.id]);
  }
}
