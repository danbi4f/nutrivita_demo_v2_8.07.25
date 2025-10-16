import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/app_search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/service/survey_foods_description_service.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/data/repository/app_favorite_repository.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';

List<RepositoryProvider> buildRepositories({
  SurveyFoodsByCategoryService? surveyService,
  CompleteFoodService? completeFoodService,
  SurveyFoodsDescriptionService? surveyFoodsDescriptionService,
  DatabaseService? databaseService,
}) {
  // Jeśli test nie poda mocka, użyj domyślnych instancji
  final surveySvc = surveyService ?? SurveyFoodsByCategoryService();
  final completeSvc = completeFoodService ?? CompleteFoodService();
  final descriptionSvc =
      surveyFoodsDescriptionService ?? SurveyFoodsDescriptionService();
  final dbSvc = databaseService ?? DatabaseService.instance;

  final completeFoodRepository = CompleteFoodRepository(
    surveyFoodsByCategoryService: surveySvc,
    completFoodService: completeSvc,
  );

  final surveyFoodsByCategoryRepository = SurveyFoodsByCategoryRepository(
    surveySvc,
  );
  final surveyFoodsDescriptionRepository = SurveyFoodsDescriptionRepository(
    descriptionSvc,
  );
  final appFoodRepository = AppFoodRepository(
    surveyFoodsByCategoryRepository: surveyFoodsByCategoryRepository,
    completeFoodRepository: completeFoodRepository,
  );
  final appSearchEngineRepository = AppSearchEngineRepository(
    surveyFoodsDescriptionRepository: surveyFoodsDescriptionRepository,
  );
  final appFavoriteRepository = AppFavoriteRepository(dbService: dbSvc);

  final combinedDataService = CombinedDataService(
    appFavoriteRepository: appFavoriteRepository,
    appSearchEngineRepository: appSearchEngineRepository,
    appFoodRepository: appFoodRepository,
  );

  return [
    RepositoryProvider<CombinedDataService>(create: (_) => combinedDataService),
  ];
}
