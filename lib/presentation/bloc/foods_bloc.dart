import 'package:flutter_bloc/flutter_bloc.dart';
import 'foods_event.dart';
import 'foods_state.dart';
import '../../domain/usecases/get_sorted_foods_by_nutrient.dart';
class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final GetSortedFoodsByNutrient getSortedFoodsByNutrient;
  FoodsBloc(this.getSortedFoodsByNutrient) : super(FoodsInitial()) {
    on<LoadFoodsByNutrient>(_onLoadFoodsByNutrient);
  }
  Future<void> _onLoadFoodsByNutrient(
      LoadFoodsByNutrient event, Emitter<FoodsState> emit) async {
    emit(FoodsLoading());
    try {
      final foods = await getSortedFoodsByNutrient(event.nutrientNumber);
      emit(FoodsLoaded(foods));
    } catch (e) {
      emit(FoodsError(e.toString()));
    }
  }
}