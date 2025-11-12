import 'package:get_it/get_it.dart';
import 'package:nutrivita_demo_v2/core/database/sql/database_service.dart';
import 'package:nutrivita_demo_v2/core/utils/conversion_service.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/message_pack_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/data/repositories/category_repository_impl.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/category_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/data/datasources/faves_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/faves/data/repository/in_memory_favorite_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/is_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/data/repositories/food_repository_impl.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_all_foods.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_foods_by_fdcids.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/search_foods.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';

final sl = GetIt.instance;

void configureDependencies() {
  sl.registerSingleton<ConversionService>(ConversionService());
  sl.registerSingleton<DatabaseService>(DatabaseService.instance);

  //!=============================== D A T A _ S O U R C E =============================

  //----------------1---------------------------------------------------------
  //? Data sources
  sl.registerSingletonAsync<CategoryLocalDataSource>(
    () => MessagePackCategoryLocalDataSourceImpl.init(),
  );

  //-----------------2--------------------------------------------------------
  //! Data sources
  sl.registerSingleton<FavesLocalDataSource>(
    FavesLocalDataSourceImpl(dbService: sl()),
  ); //! not working
  //!=============================== R E P O S I T O R Y =============================

  //----------------1---------------------------------------------------------
  //? Repository
  sl.registerSingletonAsync<CategoryRepository>(() async {
    final dataSource = await sl.getAsync<CategoryLocalDataSource>();
    return CategoryRepositoryImpl(categoryLocalDataSource: dataSource);
  }, );

  //---------------2---------------------------------------------------------
  //? Repository
  sl.registerSingletonAsync<FoodRepository>(() async {
    final categoryDataSource = await sl.getAsync<CategoryLocalDataSource>();
    return FoodRepositoryImpl(
      localDataSource: categoryDataSource,
      conversionService: sl(),
    );
  }, );

  //---------------3---------------------------------------------------------
  //? Repository
  sl.registerSingletonAsync<FavesRepository>(() async {
    final repository = InMemoryFavesRepository(localDataSource: sl());
    await repository.init();
    return repository;
  });

  //!======================================================================================

  //? Use cases
  sl.registerLazySingleton(() => GetAllCategories(sl()));

  //=========================== F O O D S =================================
  //? Use cases
  sl.registerLazySingleton(() => GetFoodByFdcId(sl()));
  sl.registerLazySingleton(() => GetAllFoods(sl()));
  sl.registerLazySingleton(() => GetFoodsByFdcids(sl()));
  sl.registerLazySingleton(() => SearchFoodsUseCase(sl()));

  //=========================== F A V E S =================================
  //? Use cases
  sl.registerLazySingleton(() => GetFavesFuture(sl()));
  sl.registerLazySingleton(() => GetFavesStream(sl()));
  sl.registerLazySingleton(() => AddToFaveUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFaveUseCase(sl()));
  sl.registerLazySingleton(() => IsFave(sl()));

  //? Bloc
  sl.registerLazySingleton(() => CategoryBloc(getAllCategories: sl()));
  //? Bloc
  sl.registerLazySingleton(() => FoodBloc(getAllFoods: sl(), searchFoods: sl()));
  sl.registerLazySingleton(
    () => IsFaveBloc(
      getFavesStream: sl(),
      addToFaveUseCase: sl(),
      removeFaveUseCase: sl(),
      getFavesFuture: sl(),
    ),
  );
  //? Bloc
  sl.registerLazySingleton(
    () => FaveBloc(
      favesFuture: sl(),
      favesStream: sl(),
      addFave: sl(),
      removeFave: sl(),
      getFoodByFdcId: sl(),
    ),
  );
}
