import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/app_search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/data/repository/in_memory_favorite_repository%20.dart';

class CombinedDataService {
  InMemoryFavoriteRepository inMemoryFavoriteRepository;
  AppSearchEngineRepository appSearchEngineRepository;
  AppFoodRepository appFoodRepository;

  CombinedDataService({
    required this.inMemoryFavoriteRepository,
    required this.appSearchEngineRepository,
    required this.appFoodRepository,
  });
}
