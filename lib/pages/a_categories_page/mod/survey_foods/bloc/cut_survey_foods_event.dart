import 'package:equatable/equatable.dart';

abstract class CutSurveyFoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCutSurveyFoodsByNutrient extends CutSurveyFoodsEvent {
  LoadCutSurveyFoodsByNutrient(this.nutrientNumber);

  final String nutrientNumber;

  @override
  List<Object?> get props => [nutrientNumber];
}
