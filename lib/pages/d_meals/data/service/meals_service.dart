import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/domain/model/meal.dart';

class MealsService {
  final DatabaseService _db = DatabaseService.instance;

  Future<int> insertMeal(Meal meal) => _db.insertMeal(meal);
  Future<List<Meal>> getMeals() => _db.getMeals();
  Future<int> deleteMeal(int id) => _db.deleteMeal(id);
  Future<int> updateMeal(Meal meal) => _db.updateMeal(meal);
}
