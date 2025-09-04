import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/meal.dart';
import 'package:nutrivita_demo_v2/shared/repositories/meals_repository.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealsRepository repository;

  MealsBloc(this.repository) : super(MealsState()) {
    on<LoadMeals>(_onLoadMeals);
    on<AddMeal>(_onAddMeal);
    on<RemoveMeal>(_onRemoveMeal);
    on<UpdateMeal>(_onUpdateMeal);
  }

  Future<void> _onLoadMeals(LoadMeals event, Emitter<MealsState> emit) async {
    emit(state.copyWith(meals: const DelayedResult.inProgress()));
    try {
      final meals = await repository.getAllMeals();
      emit(state.copyWith(meals: DelayedResult.fromValue(meals)));
    } catch (e) {
      emit(
        state.copyWith(
          meals: DelayedResult.fromError(
            e is Exception ? e : Exception(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _onAddMeal(AddMeal event, Emitter<MealsState> emit) async {
    final mealWithId = await repository.addMeal(event.meal);
    final current = state.meals.value ?? [];
    emit(
      state.copyWith(meals: DelayedResult.fromValue([...current, mealWithId])),
    );
  }

  Future<void> _onRemoveMeal(RemoveMeal event, Emitter<MealsState> emit) async {
    await repository.removeMeal(event.id);
    final current = state.meals.value ?? [];
    emit(
      state.copyWith(
        meals: DelayedResult.fromValue(
          current.where((meal) => meal.id != event.id).toList(),
        ),
      ),
    );
  }

  Future<void> _onUpdateMeal(UpdateMeal event, Emitter<MealsState> emit) async {
    await repository.updateMeal(event.meal);
  }
}
