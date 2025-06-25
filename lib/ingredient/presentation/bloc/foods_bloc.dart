import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'foods_event.dart';
import 'foods_state.dart';
import '../../domain/usecases/get_sorted_foods_by_nutrient.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  FoodsBloc(this.getSortedFoodsByNutrient) : super(FoodsState()) {
    on<LoadFoodsByNutrient>(_onLoadFoodsByNutrient);
  }

  final GetSortedFoodsByNutrient getSortedFoodsByNutrient;

  Future<void> _onLoadFoodsByNutrient(
    LoadFoodsByNutrient event,
    Emitter<FoodsState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final foods = await getSortedFoodsByNutrient(event.nutrientNumber);
      emit(
        state.copyWith(
          foods: foods,
          delayedResult: const DelayedResult.fromValue(
            'Foods loaded successfully',
          ),
        ),
      );
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
