part of 'favorite_foods_bloc.dart';

sealed class FavoriteFoodsState extends Equatable {
  const FavoriteFoodsState();
  
  @override
  List<Object> get props => [];
}

final class FavoriteFoodsInitial extends FavoriteFoodsState {}
