import 'package:nutrivita_demo_v2/shared/models/meal.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'tables/table_favorites.dart';
part 'tables/table_meals.dart';

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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(FavoritesTable.createTableFavorites);
    await db.execute(MealsTable.createTableMeals);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // tworzymy brakującą tabelę jeśli jej nie ma
      await db.execute(MealsTable.createTableMeals);
    }
    // tutaj możesz dodawać kolejne if (oldVersion < 3) { ... } przy następnych migracjach
  }
}
