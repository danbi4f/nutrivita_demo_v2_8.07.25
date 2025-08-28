part of '../database_service.dart';

class FavoritesTable {
  static const String tableNameFavorites = 'favorite_foods';
  static const String idColumnNameFavorites = 'id';
  static const String descriptionColumnNameFavorites = 'description';
  static const String descriptionPLColumnNameFavorites = 'descriptionPL';
  static const String foodClassColumnNameFavorites = 'foodClass';
  static const String fdcIdColumnNameFavorites = 'fdcId';
  static const String nutrientsColumnNameFavorites = 'nutrients';
  static const String nameNutrientsColumnNameFavorite = 'nameNutrient';
  static const String unitNameNutrientsColumnNameFavorite = 'unitNameNutrient';

  static String get createTableFavorites => '''
    CREATE TABLE IF NOT EXISTS $tableNameFavorites (
      $idColumnNameFavorites INTEGER PRIMARY KEY AUTOINCREMENT,
      $descriptionColumnNameFavorites TEXT,
      $descriptionPLColumnNameFavorites TEXT,
      $foodClassColumnNameFavorites TEXT,
      $fdcIdColumnNameFavorites INTEGER UNIQUE,
      $nutrientsColumnNameFavorites TEXT,
      $nameNutrientsColumnNameFavorite TEXT,
      $unitNameNutrientsColumnNameFavorite TEXT
    )
  ''';
}

extension FavoritesCrud on DatabaseService {
  // INSERT
  Future<int> insertFavorite(SurveyFoods food) async {
    final db = await DatabaseService.instance.database;
    return await db.insert(
      FavoritesTable.tableNameFavorites,
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL
  Future<List<SurveyFoods>> getFavorites() async {
    final db = await DatabaseService.instance.database;
    final maps = await db.query(FavoritesTable.tableNameFavorites);
    return maps.map((map) => SurveyFoods.fromJson(map)).toList();
  }

  // DELETE
  Future<int> deleteFavorite(int fdcId) async {
    final db = await DatabaseService.instance.database;
    return await db.delete(
      FavoritesTable.tableNameFavorites,
      where: '${FavoritesTable.fdcIdColumnNameFavorites} = ?',
      whereArgs: [fdcId],
    );
  }

  // UPDATE
  Future<int> updateFavorite(SurveyFoods food) async {
    final db = await DatabaseService.instance.database;
    return await db.update(
      FavoritesTable.tableNameFavorites,
      food.toMap(),
      where: '${FavoritesTable.idColumnNameFavorites} = ?',
      whereArgs: [food.fdcId],
    );
  }
}
