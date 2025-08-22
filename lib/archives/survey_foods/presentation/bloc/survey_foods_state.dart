part of 'survey_foods_bloc.dart';

class SurveyFoodsState extends Equatable {
  const SurveyFoodsState({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
    this.nutrientNumber = '',
  });

  final DelayedResult<String> delayedResult;
  final List<SurveyModel> foods;
  final String nutrientNumber;

  SurveyFoodsState copyWith({
    List<SurveyModel>? foods,
    DelayedResult<String>? delayedResult,
    String? nutrientNumber,
  }) {
    return SurveyFoodsState(
      nutrientNumber: nutrientNumber ?? this.nutrientNumber,

      foods: foods ?? this.foods,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object?> get props => [foods, delayedResult, nutrientNumber];
}
