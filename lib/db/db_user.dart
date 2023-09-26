import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../users/user.dart';

class DatabaseHelperUser {
  DatabaseHelperUser._();

  static const DATABASE_NAME = "user_db.db";
  static final DatabaseHelperUser instance = DatabaseHelperUser._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), DATABASE_NAME),
        version: 1,
        onCreate:(Database db, int version) async {
          await db.execute("CREATE TABLE ${User.TABLE_NAME}(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, fullname TEXT, phone TEXT)");
        }
    );
  }

  Future<void> setUser(User user) async {
    final db = await database;
    await db!.delete(User.TABLE_NAME); // Clear any existing user data
    await db.insert(User.TABLE_NAME, user.toJson());
  }

  Future<User?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(User.TABLE_NAME);

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        fullname: maps[0]['fullname'],
        phone: maps[0]['phone'],
      );
    }

    return null; // No user data found
  }
}

