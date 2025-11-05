import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/data/repositories/category_repository_impl.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/foods/data/repositories/food_repository_impl.dart';
import 'package:nutrivita_demo_v2/core/utils/conversion_service.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';
import 'package:nutrivita_demo_v2/features/faves/data/database/database_service.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_all_foods.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_foods_by_fdcids.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/search_foods.dart';

Future<List<RepositoryProvider>> buildRepositories({
  CategoryLocalDataSource? surveySvc,
  ConversionService? completeFoodService,
  DatabaseService? databaseService,
}) async {
  //-----------------------------------------------------------------------------------
  // If the test fails to provide a mock, use the default instances
  final localDataSource =  surveySvc ?? await CategoryLocalDataSourceImpl.init();
  final conversionService = completeFoodService ?? ConversionService();
  final dbService = databaseService ?? DatabaseService.instance;

  //-----------------------------------------------------------------------------------
  final foodRepository = FoodRepositoryImpl(
    localDataSource: localDataSource,
    conversionService: conversionService,
  );

  final categoryRepository = CategoryRepositoryImpl(categoryLocalDataSource: localDataSource,
  );


  final inMemoryFaveRepository = InMemoryFavesRepository(
    dbService: dbService,
  );
  await inMemoryFaveRepository.init();
   //-----------------------------------------------------------------------------------
  final GetFavesFuture favesFuture = GetFavesFuture(inMemoryFaveRepository);
  final GetFavesStream favesStream = GetFavesStream(inMemoryFaveRepository);
  final AddToFaveUseCase addFave = AddToFaveUseCase(inMemoryFaveRepository);
  final RemoveFaveUseCase removeFave = RemoveFaveUseCase(inMemoryFaveRepository);


  //-----------------------------------------------------------------------------------
  final GetFoodByFdcId getFoodByFdcId = GetFoodByFdcId(foodRepository);
  final GetAllFoods getAllFoods = GetAllFoods(foodRepository);
  final GetFoodsByFdcids getFoodsByFdcids = GetFoodsByFdcids(foodRepository);
  final SearchFoodsUseCase searchFoodsUseCase = SearchFoodsUseCase(foodRepository);
  
//------------------------------------------------------------------------------------

final GetAllCategories getAllCategories = GetAllCategories(categoryRepository);


  //-----------------------------------------------------------------------------------
  final combinedDataService = CombinedDataService(
    inMemoryFaveRepository: inMemoryFaveRepository,
    categoryRepository: categoryRepository,
    foodRepository: foodRepository,
    addToFaveUseCase: addFave,
    removeFaveUseCase: removeFave,
    favesFuture: favesFuture,
    favesStream: favesStream,
    getFoodByFdcId: getFoodByFdcId,
    getAllFoods: getAllFoods,
    getFoodsByFdcids: getFoodsByFdcids,
    searchFoodsUseCase: searchFoodsUseCase,
    getAllCategories: getAllCategories,

  );

  return [
    RepositoryProvider<CombinedDataService>(create: (_) => combinedDataService),
  ];
}
