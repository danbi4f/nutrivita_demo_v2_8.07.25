import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_all_foods.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/search_foods.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  GetAllFoods getAllFoods;
  SearchFoodsUseCase searchFoods;
  FoodBloc({required this.getAllFoods, required this.searchFoods})
    : super(FoodState()) {
    on<FetchFoods>(_onFetchFoods);
    on<SearchFoods>(_onSearchFoods);
  }

  Future<void> _onFetchFoods(FetchFoods event, Emitter<FoodState> emit) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
    final failureOrData = await getAllFoods(NoParams());
    failureOrData.fold(
      (failure) {
        emit(
          state.copyWith(
            loadingResult: DelayedResult.fromError(
              Exception(failure.toString()),
            ),
          ),
        );
      },
      (foods) {
        emit(
          state.copyWith(
            foods: foods,
            loadingResult: const DelayedResult.idle(),
          ),
        );
      },
    );
  }

  Future<void> _onSearchFoods(
    SearchFoods event,
    Emitter<FoodState> emit,
  ) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
    final failureOrData = await searchFoods(event.query);
    failureOrData.fold(
      (failure) {
        emit(
          state.copyWith(
            loadingResult: DelayedResult.fromError(
              Exception(failure.toString()),
            ),
          ),
        );
      },
      (foods) {
        emit(
          state.copyWith(
            foods: foods,
            loadingResult: const DelayedResult.idle(),
          ),
        );
      },
    );
  }
}
