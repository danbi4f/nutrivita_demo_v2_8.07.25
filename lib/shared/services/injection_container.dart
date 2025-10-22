import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/data/repository/app_search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/data/service/survey_foods_description_service.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/data/repository/app_favorite_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/shared/services/database_service/database_service.dart';

Future<List<RepositoryProvider>> buildRepositories({
  SurveyFoodsByCategoryService? surveySvc,
  CompleteFoodService? completeFoodService,
  SurveyFoodsDescriptionService? surveyFoodsDescriptionService,
  DatabaseService? databaseService,
}) async {
  //-----------------------------------------------------------------------------------
  // Jeśli test nie poda mocka, użyj domyślnych instancji
  final surveyService = surveySvc ?? await SurveyFoodsByCategoryService.init();
  final completeService = completeFoodService ?? CompleteFoodService();
  final descriptionService =
      surveyFoodsDescriptionService ?? SurveyFoodsDescriptionService();
  final dbService = databaseService ?? DatabaseService.instance;

  //-----------------------------------------------------------------------------------
  final completeFoodRepository = CompleteFoodRepository(
    surveyFoodsByCategoryService: surveyService,
    completFoodService: completeService,
  );

  final surveyFoodsByCategoryRepository = SurveyFoodsByCategoryRepository(
    surveyService,
  );
  final surveyFoodsDescriptionRepository = SurveyFoodsDescriptionRepository(
    descriptionService,
  );
  final appFoodRepository = AppFoodRepository(
    surveyFoodsByCategoryRepository: surveyFoodsByCategoryRepository,
    completeFoodRepository: completeFoodRepository,
  );
  final appSearchEngineRepository = AppSearchEngineRepository(
    surveyFoodsDescriptionRepository: surveyFoodsDescriptionRepository,
  );
  final appFavoriteRepository = AppFavoriteRepository(dbService: dbService);
  final inMemoryFavoriteRepository = InMemoryFavoriteRepository(
    dbService: dbService,
  );
  await inMemoryFavoriteRepository.init();

  //-----------------------------------------------------------------------------------
  final combinedDataService = CombinedDataService(
    appFavoriteRepository: appFavoriteRepository,
    appSearchEngineRepository: appSearchEngineRepository,
    appFoodRepository: appFoodRepository,
    inMemoryFavoriteRepository: inMemoryFavoriteRepository,
  );

  return [
    RepositoryProvider<CombinedDataService>(create: (_) => combinedDataService),
  ];
}
