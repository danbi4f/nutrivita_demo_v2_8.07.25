import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/data/repository/in_memory_favorite_repository%20.dart';

class CombinedDataService {

  // AppSearchEngineRepository appSearchEngineRepository;
  AppFoodRepository appFoodRepository;
  InMemoryFaveRepository inMemoryFaveRepository;

  CombinedDataService({
    // required this.appSearchEngineRepository,
    required this.appFoodRepository,
    required this.inMemoryFaveRepository,
  });
}
