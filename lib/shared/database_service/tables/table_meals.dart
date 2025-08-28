part of '../database_service.dart';

class MealsTable {
  static const String tableNameMeals = 'meals';
  static const String idColumnNameMeals = 'id';
  static const String nameColumnNameMeals = 'name';
  static const String foodsColumnNameMeals = 'foods';

  static String get createTableMeals => '''
      CREATE TABLE IF NOT EXISTS $tableNameMeals (
        $idColumnNameMeals INTEGER PRIMARY KEY AUTOINCREMENT,
        $nameColumnNameMeals TEXT,
        $foodsColumnNameMeals TEXT
      )
    ''';
}

extension MealsCrud on DatabaseService {
  // INSERT
  Future<int> insertMeal(Meal meal) async {
    final db = await DatabaseService.instance.database;
    final id = await db.insert(
      MealsTable.tableNameMeals,
      meal.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // GET ALL
  Future<List<Meal>> getMeals() async {
    final db = await DatabaseService.instance.database;
    final maps = await db.query(MealsTable.tableNameMeals);
    return maps.map((map) => Meal.fromMap(map)).toList();
  }

  // DELETE
  Future<int> deleteMeal(int id) async {
    final db = await DatabaseService.instance.database;
    return await db.delete(
      MealsTable.tableNameMeals,
      where: '${MealsTable.idColumnNameMeals} = ?',
      whereArgs: [id],
    );
  }

  // UPDATE
  Future<int> updateMeal(Meal meal) async {
    final db = await DatabaseService.instance.database;
    return await db.update(
      MealsTable.tableNameMeals,
      meal.toMap(),
      where: '${MealsTable.idColumnNameMeals} = ?',
      whereArgs: [meal.id],
    );
  }
}
