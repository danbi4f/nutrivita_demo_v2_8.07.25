import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/data/repositories/category_repository_impl.dart';
import 'package:nutrivita_demo_v2/features/foods/data/repositories/food_repository_impl.dart';
import 'package:nutrivita_demo_v2/core/utils/conversion_service.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';
import 'package:nutrivita_demo_v2/features/faves/data/database/database_service.dart';

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
  final combinedDataService = CombinedDataService(
    inMemoryFaveRepository: inMemoryFaveRepository,
    categoryRepository: categoryRepository,
    foodRepository: foodRepository,
  );

  return [
    RepositoryProvider<CombinedDataService>(create: (_) => combinedDataService),
  ];
}
