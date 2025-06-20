import 'package:equatable/equatable.dart';
import '../../domain/entities/food_entity.dart';
abstract class FoodsState extends Equatable {
  @override
  List<Object?> get props => [];
}
class FoodsInitial extends FoodsState {}
class FoodsLoading extends FoodsState {}
class FoodsLoaded extends FoodsState {
  final List<FoodEntity> foods;
  FoodsLoaded(this.foods);
  @override
  List<Object?> get props => [foods];
}
class FoodsError extends FoodsState {
  final String message;
  FoodsError(this.message);
  @override
  List<Object?> get props => [message];
}