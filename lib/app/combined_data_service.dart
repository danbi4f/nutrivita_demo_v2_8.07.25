import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';

class CombinedDataService {

  CategoryRepository categoryRepository;
  InMemoryFavesRepository inMemoryFaveRepository;
  FoodRepository foodRepository;
  AddToFaveUseCase addToFaveUseCase;
  RemoveFaveUseCase removeFaveUseCase;
  GetFavesFuture favesFuture;
  GetFavesStream favesStream;
  GetFoodByFdcId getFoodByFdcId;
  

  CombinedDataService({
    required this.categoryRepository,
    required this.inMemoryFaveRepository,
    required this.foodRepository,
    required this.addToFaveUseCase,
    required this.removeFaveUseCase,
    required this.favesFuture,
    required this.favesStream,
    required this.getFoodByFdcId,
  });
}
