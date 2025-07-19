import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_food_nutrient_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_nutrient_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/service/asset_survey_service.dart';

class SurveyRepository {
  const SurveyRepository(this.assetSurveyService);

  final AssetSurveyService assetSurveyService;

  Future<List<SurveyModel>> fetchSurveyFoods() {
    return assetSurveyService.fetchSurveyFoods();
  }

  Future<List<SurveyModel>> getSortedFoodsByNutrient(
    String nutrientNumberSearch,
  ) async {
    final List<SurveyModel> fundationFoods = await fetchSurveyFoods();

    fundationFoods.sort((a, b) {
      double aAmount =
          a.foodNutrients
              .firstWhere(
                (foodNutrient) =>
                    foodNutrient.nutrient.number == nutrientNumberSearch,
                orElse:
                    () => SurveyFoodNutrientModel(
                      amount: 0.0,
                      nutrient: SurveyNutrientModel(
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
                    () => SurveyFoodNutrientModel(
                      amount: 0.0,
                      nutrient: SurveyNutrientModel(
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
