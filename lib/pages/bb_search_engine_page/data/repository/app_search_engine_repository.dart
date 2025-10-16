import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

class AppSearchEngineRepository {
  final SurveyFoodsDescriptionRepository surveyFoodsDescriptionRepository;
  AppSearchEngineRepository({required this.surveyFoodsDescriptionRepository});

  Future<DelayedResult<List<SurveyFoodsDescription>>> getDescription() async {
    return surveyFoodsDescriptionRepository.getDescription();
  }
}
