part of 'favorite_foods_bloc.dart';

abstract class FavoriteFoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoriteFoodsEvent {}

class AddFavoriteFood extends FavoriteFoodsEvent {
  final SurveyFoods food;
  AddFavoriteFood(this.food);

  @override
  List<Object?> get props => [food];
}

class RemoveFavoriteFood extends FavoriteFoodsEvent {
  final int fdcId;
  RemoveFavoriteFood(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

class UpdateFavoriteFood extends FavoriteFoodsEvent {
  final SurveyFoods food;
  UpdateFavoriteFood(this.food);

  @override
  List<Object?> get props => [food];
}
