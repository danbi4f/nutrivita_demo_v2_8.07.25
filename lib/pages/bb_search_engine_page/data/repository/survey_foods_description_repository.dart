import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/service/survey_foods_description_service.dart';

class SurveyFoodsDescriptionRepository {
  const SurveyFoodsDescriptionRepository(this.surveyFoodsDescriptionService);

  final SurveyFoodsDescriptionService surveyFoodsDescriptionService;

  Future<DelayedResult<List<SurveyFoodsDescription>>> getDescription() async {
    try {
      final description = await surveyFoodsDescriptionService.getDescription();
      return DelayedResult.fromValue(description);
    } catch (e) {
      return DelayedResult.fromError(Exception(e.toString()));
    }
  }
}
