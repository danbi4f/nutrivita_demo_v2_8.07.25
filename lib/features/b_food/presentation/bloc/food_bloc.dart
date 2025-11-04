import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final CombinedDataService _combinedDataService;
  FoodBloc({required combinedDataService})
    : _combinedDataService = combinedDataService,
      super(FoodState()) {
    on<FetchFoods>(_onFetchFoods);
    on<SearchFoods>(_onSearchFoods);
  }

  Future<void> _onFetchFoods(FetchFoods event, Emitter<FoodState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final foods =
          await _combinedDataService.appFoodRepository.getAllCompleteFoods();
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
      final foods = await _combinedDataService.appFoodRepository.searchFoods(
        event.query,
      );
      emit(state.copyWith(foods: foods));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (ex) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(ex)));
    }
  }
}
