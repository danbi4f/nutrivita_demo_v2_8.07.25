import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tableNameFavorites = 'favorite_foods';
  final String _idColumnNameFavorites = 'id';

  final String _descriptionColumnNameFavorites = 'description';
  final String _descriptionPLColumnNameFavorites = 'descriptionPL';
  final String _foodClassColumnNameFavorites = 'foodClass';
  final String _fdcIdColumnNameFavorites = 'fdcId';
  final String _nutrientsColumnNameFavorites = 'nutrients';
  final String _nameNutrientsColumnNameFavorite = 'nameNutrient';
  final String _unitNameNutrientsColumnNameFavorite = 'unitNameNutrient';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'master_db.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableNameFavorites (
        $_idColumnNameFavorites INTEGER PRIMARY KEY AUTOINCREMENT,
        $_descriptionColumnNameFavorites TEXT,
        $_descriptionPLColumnNameFavorites TEXT,
        $_foodClassColumnNameFavorites TEXT,
        $_fdcIdColumnNameFavorites INTEGER UNIQUE,
        $_nutrientsColumnNameFavorites TEXT,
        $_nameNutrientsColumnNameFavorite TEXT,
        $_unitNameNutrientsColumnNameFavorite TEXT
      )
    ''');
  }

  // INSERT
  Future<int> insertFavorite(SurveyFoods food) async {
    final db = await database;
    return await db.insert(
      _tableNameFavorites,
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL
  Future<List<SurveyFoods>> getFavorites() async {
    final db = await database;
    final maps = await db.query(_tableNameFavorites);
    return maps.map((map) => SurveyFoods.fromJson(map)).toList();
  }

  // DELETE
  Future<int> deleteFavorite(int fdcId) async {
    final db = await database;
    return await db.delete(
      _tableNameFavorites,
      where: '$_fdcIdColumnNameFavorites = ?',
      whereArgs: [fdcId],
    );
  }

  // UPDATE
  Future<int> updateFavorite(SurveyFoods food) async {
    final db = await database;
    return await db.update(
      _tableNameFavorites,
      food.toMap(),
      where: '$_idColumnNameFavorites = ?',
      whereArgs: [food.fdcId],
    );
  }
}
