import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class CombinedDataService {

  CategoryRepository categoryRepository;
  InMemoryFavesRepository inMemoryFaveRepository;
  FoodRepository foodRepository;

  CombinedDataService({
    required this.categoryRepository,
    required this.inMemoryFaveRepository,
    required this.foodRepository,
  });
}
