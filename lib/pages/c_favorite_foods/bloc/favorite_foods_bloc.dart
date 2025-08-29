import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';
import 'package:nutrivita_demo_v2/shared/database_service/database_service.dart';

part 'favorite_foods_event.dart';
part 'favorite_foods_state.dart';

class FavoriteFoodsBloc extends Bloc<FavoriteFoodsEvent, FavoriteFoodsState> {
  FavoriteFoodsBloc() : super(const FavoriteFoodsState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteFood>(_onAddFavoriteFood);
    on<RemoveFavoriteFood>(_onRemoveFavoriteFood);
    on<UpdateFavoriteFood>(_onUpdateFavoriteFood);
  }

  final _dbService = DatabaseService.instance;

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteFoodsState> emit,
  ) async {
    emit(state.copyWith(favorites: const DelayedResult.inProgress()));

    try {
      final foods = await _dbService.getFavorites();
      emit(state.copyWith(favorites: DelayedResult.fromValue(foods)));
    } catch (e) {
      emit(
        state.copyWith(
          favorites: DelayedResult.fromError(
            e is Exception ? e : Exception(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _onAddFavoriteFood(
    AddFavoriteFood event,
    Emitter<FavoriteFoodsState> emit,
  ) async {
    await _dbService.insertFavorite(event.food);

    final current = state.favorites.value ?? [];
    emit(
      state.copyWith(
        favorites: DelayedResult.fromValue([...current, event.food]),
      ),
    );
  }

  Future<void> _onRemoveFavoriteFood(
    RemoveFavoriteFood event,
    Emitter<FavoriteFoodsState> emit,
  ) async {
    await _dbService.deleteFavorite(event.fdcId);

    final current = state.favorites.value ?? [];
    emit(
      state.copyWith(
        favorites: DelayedResult.fromValue(
          current.where((food) => food.fdcId != event.fdcId).toList(),
        ),
      ),
    );
  }

  Future<void> _onUpdateFavoriteFood(
    UpdateFavoriteFood event,
    Emitter<FavoriteFoodsState> emit,
  ) async {
    await _dbService.updateFavorite(event.food);
  }
}
