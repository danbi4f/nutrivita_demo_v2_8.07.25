import 'package:nutrivita_demo_v2/ingredient/data/model/food_nutrient_model.dart';
import 'package:nutrivita_demo_v2/ingredient/data/model/nutrient_model.dart';

import '../../domain/entities/food_entity.dart';
import '../../domain/repositories/food_repository.dart';
import '../service/asset_json_service.dart';

class AppFoodRepository implements FoodRepository {
  AppFoodRepository(this.assetJsonService);

  final AssetJsonService assetJsonService;

  Future<List<FoodEntity>> fetchFinalFoods() {
    return assetJsonService.loadListFinalFood();
  }

  @override
  Future<List<FoodEntity>> getSortedFoodsByNutrient(
    String nutrientNumberSearch,
  ) async {
    final List<FoodEntity> fundationFoods = await fetchFinalFoods();

    fundationFoods.sort((a, b) {
      double aAmount =
          a.foodNutrients
              .firstWhere(
                (foodNutrient) =>
                    foodNutrient.nutrient.number == nutrientNumberSearch,
                orElse:
                    () => FoodNutrientModel(
                      amount: 0.0,
                      nutrient: NutrientModel(
                        number: '0',
                        name: 'null',
                        unitName: 'null',
                      ),
                    ),
              )
              .amount;
      double bAmount =
          b.foodNutrients
              .firstWhere(
                (foodNutrient) =>
                    foodNutrient.nutrient.number == nutrientNumberSearch,
                orElse:
                    () => FoodNutrientModel(
                      amount: 0.0,
                      nutrient: NutrientModel(
                        number: '0',
                        name: 'null',
                        unitName: 'null',
                      ),
                    ),
              )
              .amount;
      return bAmount.compareTo(aAmount);
    });
    return fundationFoods;
  }
}
