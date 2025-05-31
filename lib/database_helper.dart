import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''   CREATE table settings (
             id INTEGER PRIMARY KEY AUTOINCREMENT, 
             isDarkMode INTEGER NOT NULL
          )
          ''');

        // insert default values, light mode
        await db.insert('settings', {'isDarkMode': 0});
      },
    );
  }

  Future<bool> getThemePreference() async {
    final db = await database;
    final results = await db.query('settings', limit: 1);
    if (results.isNotEmpty) {
      return results.first['isDarkMode'] == 1;
    }

    return false; // Defaults to light mode
  }

  Future<void> updateThemePreference(bool isDarkMode) async {
    final db = await database;
    await db.update(
      "settings",
      {'isDarkMode': isDarkMode ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    ); // update the first row
  }
}
