import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/app_search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/data/repository/app_favorite_repository.dart';

class CombinedDataService {
  AppFavoriteRepository appFavoriteRepository;
  AppSearchEngineRepository appSearchEngineRepository;
  AppFoodRepository appFoodRepository;

  CombinedDataService({
    required this.appFavoriteRepository,
    required this.appSearchEngineRepository,
    required this.appFoodRepository,
  });
}
