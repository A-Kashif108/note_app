import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';
import '../utils/db_constants.dart';

class SQLiteDatabase {
  SQLiteDatabase._init();

  static SQLiteDatabase? _dbHelper;
  Database? _database;

  factory SQLiteDatabase() {
    return _dbHelper ??= SQLiteDatabase._init();
  }

  Future<Database> _getDB() async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String dbFilePath = join(databasePath, DBConst.dbName);
    return await openDatabase(
      dbFilePath,
      version: DBConst.dbVersion,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(DBConst.createTableCommand);
  }

  Future<void> insertNote(Note note) async {
    final Database db = await _getDB();

    int id = await db.insert(
      DBConst.tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> notes() async {
    final Database db = await _getDB();

    // querying table of notes in list of map
    final List<Map<String, dynamic>> maps = await db.query(DBConst.tableName);

    //converting list of maps to list of notes
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i][DBConst.colId] as int,
        heading: maps[i][DBConst.colTitle] as String,
        content: maps[i][DBConst.colDescription] as String,
        lastEdit: DateTime.parse(maps[i][DBConst.colTime] as String), 
        primary: int.parse(maps[i][DBConst.colPrimary] as String), 
        secondary: int.parse(maps[i][DBConst.colSecondary] as String),
      );
    });
  }

  Future<void> updateNote(Note note) async {
    final Database db = await _getDB();
    await db.update(DBConst.tableName, note.toMap(),
        where: '${DBConst.colId} = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    final Database db = await _getDB();
    await db.delete(DBConst.tableName, where: '${DBConst.colId} = ?', whereArgs: [id]);
  }
}
