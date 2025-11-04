import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository  foodRepository;
  FoodBloc({required this.foodRepository})
    : super(FoodState()) {
    on<FetchFoods>(_onFetchFoods);
    on<SearchFoods>(_onSearchFoods);
  }

  Future<void> _onFetchFoods(FetchFoods event, Emitter<FoodState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final foods =
          await foodRepository.getAllCompleteFoods();
      emit(state.copyWith(foods: foods));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (ex) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(ex)));
    }
  }

  Future<void> _onSearchFoods(
    SearchFoods event,
    Emitter<FoodState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final foods = await foodRepository.searchFoods(
        event.query,
      );
      emit(state.copyWith(foods: foods));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (ex) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(ex)));
    }
  }
}
