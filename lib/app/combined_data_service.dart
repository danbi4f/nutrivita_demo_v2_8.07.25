import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/is_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_all_foods.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_foods_by_fdcids.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/search_foods.dart';

class CombinedDataService {
  CategoryRepository categoryRepository;
  InMemoryFavesRepository inMemoryFaveRepository;
  FoodRepository foodRepository;
  AddToFaveUseCase addToFaveUseCase;
  RemoveFaveUseCase removeFaveUseCase;
  GetFavesFuture favesFuture;
  GetFavesStream favesStream;
  GetFoodByFdcId getFoodByFdcId;
  GetAllFoods getAllFoods;
  GetFoodsByFdcids getFoodsByFdcids;
  SearchFoodsUseCase searchFoodsUseCase;
  GetAllCategories getAllCategories;
  IsFave isFave;

  CombinedDataService({
    required this.categoryRepository,
    required this.inMemoryFaveRepository,
    required this.foodRepository,
    required this.addToFaveUseCase,
    required this.removeFaveUseCase,
    required this.favesFuture,
    required this.favesStream,
    required this.getFoodByFdcId,
    required this.getAllFoods,
    required this.getFoodsByFdcids,
    required this.searchFoodsUseCase,
    required this.getAllCategories,
    required this.isFave,
  });
}
