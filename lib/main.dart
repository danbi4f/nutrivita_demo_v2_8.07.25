import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/category_group/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/bloc/survey_foods_by_category_bloc.dart';
import 'package:nutrivita_demo_v2/arc/b_search_engine_page/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/arc/b_search_engine_page/data/repository/search_engine_repository.dart';
import 'package:nutrivita_demo_v2/arc/b_search_engine_page/data/service/search_engine_asset_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/bloc/search_engine_v2_bloc.dart';
import 'package:nutrivita_demo_v2/arc/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/mod/new_recipe/new_recipe_page.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';
import 'package:nutrivita_demo_v2/shared/repositories/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/shared/repositories/meals_repository.dart';
import 'package:nutrivita_demo_v2/shared/repositories/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/shared/repositories/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/shared/services/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/shared/services/meals_service.dart';
import 'package:nutrivita_demo_v2/shared/services/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/shared/services/survey_foods_description_service.dart';

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
              (_) => CategoryGroupBloc(
                CategoryGroupRepository(CategoryGroupService()),
              )..add(GetCategoryEvent()),
        ),
        BlocProvider(
          create:
              (_) => SearchEngineBloc(
                SearchEngineRepository(SearchEngineAssetService()),
              ),
        ),
        BlocProvider(create: (_) => FavoriteFoodsBloc()..add(LoadFavorites())),
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
