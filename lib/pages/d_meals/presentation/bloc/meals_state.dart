part of 'meals_bloc.dart';

class MealsState extends Equatable {
  const MealsState({this.meals = const DelayedResult.idle()});

  final DelayedResult<List<Meal>> meals;

  MealsState copyWith({DelayedResult<List<Meal>>? meals}) {
    return MealsState(meals: meals ?? this.meals);
  }

  @override
  List<Object> get props => [meals];
}
