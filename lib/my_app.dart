import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/survey_foods_by_category_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/bloc/search_engine_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/presentation/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/mod/new_recipe/new_recipe_page.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/repository/meals_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/service/meals_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/service/survey_foods_description_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  MealsBloc(MealsRepository(MealsService()))..add(LoadMeals()),
        ),
      ],
      child:
      // BlocListener<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
      //   listener: (context, state) {
      //     if (state.result.isSuccessful) {
      //       context.read<FavoriteFoodsV2Bloc>().add(LoadFavoritesFdcId());
      //     }
      //   },
      //   child:
      MaterialApp(
        routes: {'/new_recipe': (context) => const NewRecipePage()},
        theme: simpleTheme2,
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
