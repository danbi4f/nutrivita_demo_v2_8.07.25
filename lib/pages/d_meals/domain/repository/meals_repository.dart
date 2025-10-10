import 'package:nutrivita_demo_v2/pages/d_meals/domain/model/meal.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/service/meals_service.dart';

class MealsRepository {
  final MealsService service;

  MealsRepository(this.service);

  Future<List<Meal>> getAllMeals() async {
    return await service.getMeals();
  }

  Future<Meal> addMeal(Meal meal) async {
    final id = await service.insertMeal(meal);
    return Meal(id: id, name: meal.name, foods: meal.foods);
  }

  Future<void> removeMeal(int id) async {
    await service.deleteMeal(id);
  }

  Future<void> updateMeal(Meal meal) async {
    await service.updateMeal(meal);
  }
}
