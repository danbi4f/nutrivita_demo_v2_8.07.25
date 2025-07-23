part of 'cut_survey_foods_bloc.dart';

class CutSurveyFoodsState extends Equatable {
  const CutSurveyFoodsState({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
    this.nutrientNumber = '',
  });

  final DelayedResult<String> delayedResult;
  final List<CutSurveyModel> foods;
  final String nutrientNumber;

  CutSurveyFoodsState copyWith({
    List<CutSurveyModel>? foods,
    DelayedResult<String>? delayedResult,
    String? nutrientNumber,
  }) {
    return CutSurveyFoodsState(
      nutrientNumber: nutrientNumber ?? this.nutrientNumber,

      foods: foods ?? this.foods,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object?> get props => [foods, delayedResult, nutrientNumber];
}
