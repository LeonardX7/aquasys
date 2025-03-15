import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }

    return await _initDataBase();
  }

  _initDataBase() async {
    return await openDatabase(join(await getDatabasesPath(), 'aquasys.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute(_vessel);
  }

  String get _vessel => '''
  CREATE TABLE vessel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vesselName TEXT NOT NULL,
    place TEXT NOT NULL,
    portRegistry TEXT NOT NULL,
    owner TEXT NOT NULL,
    flag TEXT NOT NULL,
    IMO TEXT NOT NULL,
    operator TEXT NOT NULL,
    imageUrl TEXT
  )
  ''';
}
