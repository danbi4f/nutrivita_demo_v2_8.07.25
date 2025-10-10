import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';

import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/survey_foods_by_category_bloc.dart';

import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/bloc/search_engine_v2_bloc.dart';

import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/mod/new_recipe/new_recipe_page.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/repository/meals_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/service/meals_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/service/survey_foods_description_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SurveyFoodsByCategoryService surveyService =
      SurveyFoodsByCategoryService();
  final CompleteFoodService completeFoodService = CompleteFoodService();

  // Tworzymy repository raz i udostępniamy przez RepositoryProvider
  final completeFoodRepository = CompleteFoodRepository(
    surveyFoodsByCategoryService: surveyService,
    completFoodService: completeFoodService,
  );

  runApp(
    RepositoryProvider<CompleteFoodRepository>(
      create: (_) => completeFoodRepository,
      child: MyApp(
        completeFoodRepository: completeFoodRepository,
        surveyService: surveyService,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final CompleteFoodRepository completeFoodRepository;
  final SurveyFoodsByCategoryService surveyService;

  const MyApp({
    super.key,
    required this.completeFoodRepository,
    required this.surveyService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  MealsBloc(MealsRepository(MealsService()))..add(LoadMeals()),
        ),
        BlocProvider(
          create:
              (context) => SurveyFoodsByCategoryBloc(
                surveyFoodsByCategoryRepository:
                    SurveyFoodsByCategoryRepository(surveyService),
                completeFoodRepository: completeFoodRepository,
              )..add(LoadSurveyFoodsByCategory()),
        ),
        BlocProvider(
          create:
              (_) => SearchEngineV2Bloc(
                SurveyFoodsDescriptionRepository(
                  SurveyFoodsDescriptionService(),
                ),
              ),
        ),
        BlocProvider(
          create:
              (_) => FavoriteFoodsV2Bloc(repository: completeFoodRepository),
        ),
      ],
      child:
          BlocListener<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
            listener: (context, state) {
              if (state.result.isSuccessful) {
                context.read<FavoriteFoodsV2Bloc>().add(LoadFavoritesFdcId());
              }
            },
            child: MaterialApp(
              routes: {'/new_recipe': (context) => const NewRecipePage()},
              theme: simpleTheme2,
              debugShowCheckedModeBanner: false,
              home: SafeArea(child: HomePage()),
            ),
          ),
    );
  }
}
