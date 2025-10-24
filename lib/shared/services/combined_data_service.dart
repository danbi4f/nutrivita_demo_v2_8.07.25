import 'package:nutrivita_demo_v2/pages/a_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/c_fave/data/repository/in_memory_favorite_repository%20.dart';

class CombinedDataService {

  AppFoodRepository appFoodRepository;
  InMemoryFaveRepository inMemoryFaveRepository;

  CombinedDataService({
    required this.appFoodRepository,
    required this.inMemoryFaveRepository,
  });
}
