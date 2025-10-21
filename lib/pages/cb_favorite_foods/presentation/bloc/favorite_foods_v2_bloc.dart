import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/data/repository/app_favorite_repository.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';

part 'favorite_foods_v2_event.dart';
part 'favorite_foods_v2_state.dart';

class FavoriteFoodsV2Bloc
    extends Bloc<FavoriteFoodsV2Event, FavoriteFoodsV2State> {
  //---------------------------------------------------------------
  final CombinedDataService combinedDataService;
  late final AppFavoriteRepository appFavoriteRepository;
  late final AppFoodRepository appFoodRepository;

  FavoriteFoodsV2Bloc({required this.combinedDataService})
    : super(const FavoriteFoodsV2State()) {
    appFavoriteRepository = combinedDataService.appFavoriteRepository;
    appFoodRepository = combinedDataService.appFoodRepository;

    on<LoadFavoritesFdcId>(_onLoadFavoritesFdcId);
    on<AddFavoriteFoodFdcId>(_onAddFavoriteFoodFdcId);
    on<RemoveFavoriteFoodFdcId>(_onRemoveFavoriteFoodFdcId);
  }

  Future<void> _onLoadFavoritesFdcId(
    LoadFavoritesFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    emit(state.copyWith(favorites: const DelayedResult.inProgress()));
    try {
      final List<int> ids = await appFavoriteRepository.getAllFavorites();
      print('Loaded favorite FDC IDs: $ids -- FavoriteFoodsV2Bloc - appFavoriteRepository.getAllFavorites()');
      print('Loaded favorite FDC IDs: ${ids.length} -- FavoriteFoodsV2Bloc - appFavoriteRepository.getAllFavorites()');

      final List<CompleteFood> favorites = await appFoodRepository.getCompleteFoodsByFdcIds(ids);
      print('Loaded CompleteFood: ${favorites.length} -- FavoriteFoodsV2Bloc - appFoodRepository.getCompleteFoodsByFdcIds(ids)');

      emit(state.copyWith(favorites: DelayedResult.fromValue(favorites)));
    } catch (e) {
      emit(
        state.copyWith(
          favorites: DelayedResult.fromError(Exception(e.toString())),
        ),
      );
    }
  }

  Future<void> _onAddFavoriteFoodFdcId(
    AddFavoriteFoodFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    await appFavoriteRepository.addFavorite(event.fdcId);

    final newFood = await appFoodRepository.getCompleteFoodByFdcId(event.fdcId);
    final currentFavorites = state.favorites.value ?? [];
    final updatedFavorites = List<CompleteFood>.from(currentFavorites)
      ..add(newFood);
    emit(state.copyWith(favorites: DelayedResult.fromValue(updatedFavorites)));
  }

  //----------------------------------------------------------------

  Future<void> _onRemoveFavoriteFoodFdcId(
    RemoveFavoriteFoodFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    await appFavoriteRepository.removeFavorite(event.fdcId);

    final currentFavorites = state.favorites.value ?? [];
    final updatedFavorites =
        currentFavorites.where((food) => food.fdcId != event.fdcId).toList();


    emit(state.copyWith(favorites: DelayedResult.fromValue(updatedFavorites)));
    add(LoadFavoritesFdcId());
  }
}
