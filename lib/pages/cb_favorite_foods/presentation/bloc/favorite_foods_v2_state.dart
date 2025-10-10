part of 'favorite_foods_v2_bloc.dart';

class FavoriteFoodsV2State extends Equatable {
  final DelayedResult<List<CompleteFood>> favorites;

  const FavoriteFoodsV2State({this.favorites = const DelayedResult.idle()});

  FavoriteFoodsV2State copyWith({
    DelayedResult<List<CompleteFood>>? favorites,
  }) {
    return FavoriteFoodsV2State(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}
