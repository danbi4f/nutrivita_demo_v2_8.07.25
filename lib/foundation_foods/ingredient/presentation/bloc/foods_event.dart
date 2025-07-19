import 'package:equatable/equatable.dart';

abstract class FoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFoodsByNutrient extends FoodsEvent {
  LoadFoodsByNutrient(this.nutrientNumber);

  final String nutrientNumber;
  @override
  List<Object?> get props => [nutrientNumber];
}
