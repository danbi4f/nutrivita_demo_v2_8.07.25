part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMeals extends MealsEvent {}

class AddMeal extends MealsEvent {
  final Meal meal;
  AddMeal(this.meal);

  @override
  List<Object?> get props => [meal];
}

class RemoveMeal extends MealsEvent {
  final int id;
  RemoveMeal(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateMeal extends MealsEvent {
  final Meal meal;
  UpdateMeal(this.meal);

  @override
  List<Object?> get props => [meal];
}
