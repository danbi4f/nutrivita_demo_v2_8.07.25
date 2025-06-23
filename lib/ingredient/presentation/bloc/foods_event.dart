import 'package:equatable/equatable.dart';

abstract class FoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFoodsByNutrient extends FoodsEvent {
  final String nutrientNumber;
  LoadFoodsByNutrient(this.nutrientNumber);
  @override
  List<Object?> get props => [nutrientNumber];
}
