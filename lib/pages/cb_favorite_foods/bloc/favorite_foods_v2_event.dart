part of 'favorite_foods_v2_bloc.dart';

abstract class FavoriteFoodsV2Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavoritesFdcId extends FavoriteFoodsV2Event {}

class AddFavoriteFoodFdcId extends FavoriteFoodsV2Event {
  final int fdcId;
  AddFavoriteFoodFdcId(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

class RemoveFavoriteFoodFdcId extends FavoriteFoodsV2Event {
  final int fdcId;
  RemoveFavoriteFoodFdcId(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}
