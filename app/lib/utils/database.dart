import 'dart:developer' as developer;

import 'package:code_meter/utils/misc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AllowedAppInfo {
  const AllowedAppInfo(this.name, this.id, this.url);
  final String name;
  final String id;
  final String url;
}

class DatabaseHelper {
  static Database? _db;
  Future<String> get dbPath async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "code_meter.hazyio.com.db");
    return path;
  }

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  List<String> _createTables() {
    return [
      '''
      CREATE TABLE allowed_apps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        app_name TEXT NOT NULL,
        app_id TEXT NOT NULL UNIQUE,
        app_url TEXT NOT NULL
      );
      ''',
      '''
      CREATE TABLE reward_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        datetime TEXT NOT NULL,
        code_time INTEGER NOT NULL,
        amount INTEGER NOT NULL,
        carryover INTEGER NOT NULL
      );
      ''',
      '''
      CREATE TABLE last_checks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL UNIQUE,
        datetime TEXT NOT NULL
      );
      ''',
    ];
  }

  Future<Database> _initDB() async {
    return openDatabase(
      await dbPath,
      version: 1,
      onCreate: (db, version) async {
        for (final sql in _createTables()) {
          await db.execute(sql);
        }
      },
    );
  }

  Future<bool> clearDatabase() async {
    printIfDebug("Clearing database");
    try {
      await deleteDatabase(await dbPath);
      return true;
    } catch (e) {
      printIfDebug(e);
      return false;
    }
  }

  Future<bool> insertAllowedApps(List<AllowedAppInfo> rows) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        var batch = txn.batch();
        for (final row in rows) {
          batch.insert('allowed_apps', {
            'app_name': row.name,
            'app_id': row.id,
            'app_url': row.url,
          }, conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        await batch.commit();
      });
      return true; // all inserts succeeded
    } catch (e) {
      return false; // transaction was aborted
    }
  }

  Future<List<Map<String, dynamic>>> getAllowedApps() async {
    printIfDebug("Getting allowed apps");
    final db = await database;

    final result = await db.query(
      'allowed_apps',
      columns: ['app_id', 'app_url'],
    );
    printIfDebug("Got allowed apps, got ${result.length} items");

    // Using .from() is a cleaner way to return a mutable list
    // instead of the manual for-loop
    return List<Map<String, dynamic>>.from(result);
  }

  Future<int> updateLastCheck(String title) async {
    final db = await database;
    return await db.insert('last_checks', {
      'title': title,
      'datetime': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getLastCheck(String title) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'last_checks',
      columns: ['datetime'],
      where: 'title = ?',
      whereArgs: [title],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['datetime'] as String?;
    }

    return null;
  }

  Future<int?> countAllowedApps() async {
    final db = await database;
    final result = await db.query('allowed_apps', columns: ['id']);
    return result.length;
  }
}

class UpdateChecks {
  static const String allowedApps = "allowed_app_list";
  static const String lastUpdate = "update";
}
