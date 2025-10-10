import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/shared/database_service/database_service.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';

part 'favorite_foods_v2_event.dart';
part 'favorite_foods_v2_state.dart';

class FavoriteFoodsV2Bloc
    extends Bloc<FavoriteFoodsV2Event, FavoriteFoodsV2State> {
  FavoriteFoodsV2Bloc({required this.repository})
    : super(const FavoriteFoodsV2State()) {
    on<LoadFavoritesFdcId>(_onLoadFavoritesFdcId);
    on<AddFavoriteFoodFdcId>(_onAddFavoriteFoodFdcId);
    on<RemoveFavoriteFoodFdcId>(_onRemoveFavoriteFoodFdcId);
  }

  final _dbService = DatabaseService.instance;
  CompleteFoodRepository repository;

  Future<void> _onLoadFavoritesFdcId(
    LoadFavoritesFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    emit(state.copyWith(favorites: const DelayedResult.inProgress()));
    try {
      final List<int> ids = await _dbService.getFavoritesFdcIds();
      print('Loaded favorite FDC IDs: $ids');
      print('Loaded favorite FDC IDs: ${ids.length}');

      final favorites = await repository.getCompleteFoodsByFdcIds(ids);

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
    await _dbService.insertFavoriteFdcId(event.fdcId);
    // odśwież stan favorites
    final ids = await _dbService.getFavoritesFdcIds();
    final favorites = await repository.getCompleteFoodsByFdcIds(ids);
    emit(state.copyWith(favorites: DelayedResult.fromValue(favorites)));
  }

  Future<void> _onRemoveFavoriteFoodFdcId(
    RemoveFavoriteFoodFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    await _dbService.deleteFavoriteFdcId(event.fdcId);
    // odśwież stan favorites
    final ids = await _dbService.getFavoritesFdcIds();
    final favorites = await repository.getCompleteFoodsByFdcIds(ids);
    emit(state.copyWith(favorites: DelayedResult.fromValue(favorites)));
  }
}
