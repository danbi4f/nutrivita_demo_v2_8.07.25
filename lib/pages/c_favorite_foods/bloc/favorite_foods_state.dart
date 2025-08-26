part of 'favorite_foods_bloc.dart';

class FavoriteFoodsState extends Equatable {
  final DelayedResult<List<SurveyFoods>> favorites;

  const FavoriteFoodsState({this.favorites = const DelayedResult.idle()});

  FavoriteFoodsState copyWith({DelayedResult<List<SurveyFoods>>? favorites}) {
    return FavoriteFoodsState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}
