import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/data/repository/app_food_repository_en.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc_en/foods_event_en.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc_en/foods_state_en.dart';

class FoodsBlocEN extends Bloc<FoodsEventEN, FoodsStateEN> {
  FoodsBlocEN({required this.appFoodRepositoryEN}) : super(FoodsStateEN()) {
    on<LoadFoodsByNutrientEN>(_onLoadFoodsByNutrientEN);
  }

  final AppFoodRepositoryEN appFoodRepositoryEN;

  Future<void> _onLoadFoodsByNutrientEN(
    LoadFoodsByNutrientEN event,
    Emitter<FoodsStateEN> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final foods = await appFoodRepositoryEN.fetchFinalFoodsEN();
      emit(
        state.copyWith(
          foods: foods,
          delayedResult: const DelayedResult.fromValue(
            'Foods loaded successfully',
          ),
        ),
      );
      print('Foods loaded successfully');
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
