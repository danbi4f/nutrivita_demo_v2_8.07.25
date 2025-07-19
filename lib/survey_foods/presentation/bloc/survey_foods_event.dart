import 'package:equatable/equatable.dart';

abstract class SurveyFoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSurveyFoodsByNutrient extends SurveyFoodsEvent {
  LoadSurveyFoodsByNutrient(this.nutrientNumber);

  final String nutrientNumber;

  @override
  List<Object?> get props => [nutrientNumber];
}
