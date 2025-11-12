part of 'database_service.dart';



class CategoryCacheTable {
  static const String tableName = 'category_cache';
  static const String id = 'id';
  static const String category = 'category';
  static const String jsonData = 'json_data';

  static String get createTable => '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $category TEXT UNIQUE,
      $jsonData TEXT
    )
  ''';
}

extension CategoryCacheCrud on DatabaseService {
  Future<void> insertCategoryCache(String category, String jsonData) async {
    final db = await database;
    await db.insert(
      CategoryCacheTable.tableName,
      {
        CategoryCacheTable.category: category,
        CategoryCacheTable.jsonData: jsonData,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllCategoryCache() async {
    final db = await database;
    return await db.query(CategoryCacheTable.tableName);
  }

  Future<bool> hasCategoryCache() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ${CategoryCacheTable.tableName}'),
    );
    return (count ?? 0) > 0;
  }
}
