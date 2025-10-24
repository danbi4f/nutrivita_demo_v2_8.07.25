import 'package:nutrivita_demo_v2/pages/d_meals/domain/model/meal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'tables/table_meals.dart';
part '../../../pages/c_fave/data/service/table_favorites_fdcId.dart';
part 'tables/table_favorite_food_with_nutrients.dart'; // 🔥 nowa tabela

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'master_db.db');

    return openDatabase(
      path,
      version: 3, // 🔥 podbijamy wersję
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(FavoritesTableFdcId.createTableFavoritesFdcId);
    await db.execute(MealsTable.createTableMeals);
    await db.execute(
      FavoriteFoodWithNutrientsTable.createTableFavoriteFoodWithNutrients,
    ); // 🔥 nowa
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(MealsTable.createTableMeals);
      await db.execute(FavoritesTableFdcId.createTableFavoritesFdcId);
    }
    if (oldVersion < 3) {
      await db.execute(
        FavoriteFoodWithNutrientsTable.createTableFavoriteFoodWithNutrients,
      ); // 🔥 migracja
    }
  }
}
