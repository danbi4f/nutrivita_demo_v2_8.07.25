import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/repositories/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/shared/database_service/database_service.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';

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
      print("BLOC Loaded ids from DB: $ids");
      final favorites = await repository.getCompleteFoodsByFdcIds(ids);
      print("BLOC Fetched favorites: $favorites");

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
  }

  Future<void> _onRemoveFavoriteFoodFdcId(
    RemoveFavoriteFoodFdcId event,
    Emitter<FavoriteFoodsV2State> emit,
  ) async {
    await _dbService.deleteFavoriteFdcId(event.fdcId);
  }
}
