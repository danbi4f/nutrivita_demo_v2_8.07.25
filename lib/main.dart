import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/repository/search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/service/search_engine_asset_service.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/mod/new_recipe/new_recipe.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await ConvertToCutSurveyJson().convertSurveyFoods()/;
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        BlocProvider(create: (_) => MealsBloc()..add(LoadMeals())),
      ],
      child: MaterialApp(
        routes: {'/new_recipe': (context) => const NewRecipe()},
        theme: simpleTheme2,
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
