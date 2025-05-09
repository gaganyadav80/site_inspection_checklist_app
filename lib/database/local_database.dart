import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:sqflite/sqflite.dart';

const _tableName = 'inspection_tasks';
const _categoryTableName = 'categories';
const _itemStatusTableName = 'item_status';

final databaseProvider = Provider((_) => LocalDatabase());

class LocalDatabase {
  Database? _database;

  Future<Database> init() async {
    if (_database != null) {
      return _database!;
    }
    final databasePath = await getDatabasesPath();
    final databaseName = 'site_inspection_checklist.db';
    final databaseFile = path.join(databasePath, databaseName);

    // await File(databaseFile).delete();

    final database = await openDatabase(
      databaseFile,
      version: 1,
      onCreate: _createDatabase,
    );

    debugPrint('Database opened at $databaseFile');

    return _database = database;
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        status_id INTEGER DEFAULT NULL,
        created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        modified_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    debugPrint('Table created');

    await _initCategories(db);
    await _initItemStatuses(db);
  }

  Future<void> _initCategories(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_categoryTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    for (final category in TaskCategory.values) {
      await db.insert(
        _categoryTableName,
        {
          'id': category.id,
          'name': category.name,
        },
      );
    }

    debugPrint('$_categoryTableName table populated');
  }

  Future<void> _initItemStatuses(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_itemStatusTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    for (final itemStatus in TaskStatus.values) {
      await db.insert(
        _itemStatusTableName,
        {
          'id': itemStatus.id,
          'name': itemStatus.name,
        },
      );
    }

    debugPrint('$_itemStatusTableName table populated');
  }

  Future<List<IdName>> getCategories() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    final categories = await db.query(_categoryTableName);
    return categories.map((e) => IdName.fromJson(e)).toList();
  }

  Future<List<IdName>> getItemStatuses() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    final itemStatuses = await db.query(_itemStatusTableName);
    return itemStatuses.map((e) => IdName.fromJson(e)).toList();
  }

  Future<List<InspectionTask>> getTasks() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    final tasks = await db.rawQuery('''
      SELECT 
        $_tableName.id,
        $_tableName.name,
        category.id AS category_id,
        category.name AS category_name,
        status.id AS status_id,
        status.name AS status_name,
        $_tableName.created_at,
        $_tableName.modified_at
      FROM $_tableName
      LEFT JOIN $_categoryTableName AS category ON $_tableName.category_id = category.id
      LEFT JOIN $_itemStatusTableName AS status ON $_tableName.status_id = status.id
    ''');

    return tasks.map((e) {
      return InspectionTask.fromJson({
        ...e,
        'category': IdName(
          id: e['category_id'] as int,
          name: e['category_name'] as String,
        ).toJson(),
        'status': IdName(
          id: e['status_id'] as int,
          name: e['status_name'] as String,
        ).toJson(),
      });
    }).toList();
  }

  Future<void> insertTask(InspectionTask task) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    await db.rawInsert('''
      INSERT INTO $_tableName (name, category_id, status_id, created_at, modified_at)
      VALUES (?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
    ''', [
      task.name,
      task.category.id,
      task.status.id,
    ]);
  }

  Future<void> updateTask(int taskId, int statusId) async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    await db.rawUpdate('''
      UPDATE $_tableName
      SET status_id = ?, modified_at = CURRENT_TIMESTAMP
      WHERE id = ?
    ''', [
      statusId,
      taskId,
    ]);
  }

  Future<void> resetAllTaskStatuses() async {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    final db = _database!;
    await db.rawUpdate('''
      UPDATE $_tableName
      SET status_id = ${TaskStatus.pending.id}, modified_at = CURRENT_TIMESTAMP
    ''');
  }
}
