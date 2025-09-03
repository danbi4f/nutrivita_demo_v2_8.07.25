part of '../database_service.dart';

class FavoriteFoodWithNutrientsTable {
  static const String tableNameFavoritesFoodWithNutrients =
      'favorite_food_with_nutrients';
  static const String idColumn = 'id';
  static const String descriptionColumn = 'description';
  static const String descriptionPLColumn = 'descriptionPL';
  static const String foodClassColumn = 'foodClass';
  static const String fdcIdColumn = 'fdcId';
  static const String nutrientsColumn =
      'nutrients'; // JSON wszystkich składników

  static String get createTableFavoriteFoodWithNutrients => '''
    CREATE TABLE IF NOT EXISTS $tableNameFavoritesFoodWithNutrients (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $descriptionColumn TEXT,
      $descriptionPLColumn TEXT,
      $foodClassColumn TEXT,
      $fdcIdColumn INTEGER UNIQUE,
      $nutrientsColumn TEXT
    )
  ''';
}

extension FavoriteFoodWithNutrientsCrud on DatabaseService {
  // INSERT
  Future<int> insertFavoriteFoodWithNutrients(
    Map<String, dynamic> foodMap,
  ) async {
    final db = await DatabaseService.instance.database;
    return await db.insert(
      FavoriteFoodWithNutrientsTable.tableNameFavoritesFoodWithNutrients,
      foodMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL
  Future<List<Map<String, dynamic>>> getFavoriteFoodsWithNutrients() async {
    final db = await DatabaseService.instance.database;
    final maps = await db.query(
      FavoriteFoodWithNutrientsTable.tableNameFavoritesFoodWithNutrients,
    );
    return maps;
  }

  // DELETE
  Future<int> deleteFavoriteFoodWithNutrients(int fdcId) async {
    final db = await DatabaseService.instance.database;
    return await db.delete(
      FavoriteFoodWithNutrientsTable.tableNameFavoritesFoodWithNutrients,
      where: '${FavoriteFoodWithNutrientsTable.fdcIdColumn} = ?',
      whereArgs: [fdcId],
    );
  }

  // UPDATE
  Future<int> updateFavoriteFoodWithNutrients(
    Map<String, dynamic> foodMap,
  ) async {
    final db = await DatabaseService.instance.database;
    return await db.update(
      FavoriteFoodWithNutrientsTable.tableNameFavoritesFoodWithNutrients,
      foodMap,
      where: '${FavoriteFoodWithNutrientsTable.fdcIdColumn} = ?',
      whereArgs: [foodMap[FavoriteFoodWithNutrientsTable.fdcIdColumn]],
    );
  }
}
