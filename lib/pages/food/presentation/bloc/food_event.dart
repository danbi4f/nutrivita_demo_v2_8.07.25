part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object?> get props => [];
}

final class FetchFoods extends FoodEvent {
  const FetchFoods();
}

final class SearchFoods extends FoodEvent {
  const SearchFoods(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
