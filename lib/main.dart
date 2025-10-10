import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/my_app.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/service/survey_foods_description_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //-------------------------------SERVICES------------------------------------

  final SurveyFoodsByCategoryService surveyService =
      SurveyFoodsByCategoryService();

  final CompleteFoodService completeFoodService = CompleteFoodService();

  final SurveyFoodsDescriptionService surveyFoodsDescriptionService =
      SurveyFoodsDescriptionService();

  //-----------------------------REPOSITORY------------------------------------

  final completeFoodRepository = CompleteFoodRepository(
    surveyFoodsByCategoryService: surveyService,
    completFoodService: completeFoodService,
  );

  final surveyFoodsByCategoryRepository = SurveyFoodsByCategoryRepository(
    surveyService,
  );

  final SurveyFoodsDescriptionRepository surveyFoodsDescriptionRepository =
      SurveyFoodsDescriptionRepository(surveyFoodsDescriptionService);

  //---------------------------------------------------------------------------

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CompleteFoodRepository>(
          create: (_) => completeFoodRepository,
        ),
        RepositoryProvider<SurveyFoodsByCategoryRepository>(
          create: (context) => surveyFoodsByCategoryRepository,
        ),
        RepositoryProvider<SurveyFoodsDescriptionRepository>(
          create: (context) => surveyFoodsDescriptionRepository,
        ),
      ],
      child: MyApp(),
    ),
  );
}
