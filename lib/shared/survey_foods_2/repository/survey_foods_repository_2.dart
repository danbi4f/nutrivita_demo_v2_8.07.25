import 'package:nutrivita_demo_v2/shared/models/survey_foods_2.dart';
import 'package:nutrivita_demo_v2/shared/survey_foods_2/services/survey_foods_service_2/survey_foods_service_2.dart';

class SurveyRepository2 {
  const SurveyRepository2(this.surveyFoodsService2);

  final SurveyFoodsService2 surveyFoodsService2;

  /// Mapowanie na SearchEngineModel
  Future<List<SurveyFoods2>> getSurveyFoods2Model() async {
    var data = await surveyFoodsService2.getRawData();

    return data
        .map((map) => SurveyFoods2.fromJson(map as Map<String, dynamic>))
        .toList();
  }
}
