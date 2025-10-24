part of 'survey_foods_by_category_bloc.dart';

class SurveyFoodsByCategoryState extends Equatable {
  final DelayedResult<List<SurveyFoodsByCategory>> result;
  final DelayedResult<CompleteFood?> completeFood;

  const SurveyFoodsByCategoryState({
    this.result = const DelayedResult.idle(),
    this.completeFood = const DelayedResult.idle(),
  });

  SurveyFoodsByCategoryState copyWith({
    DelayedResult<List<SurveyFoodsByCategory>>? result,
    DelayedResult<CompleteFood?>? completeFood,
  }) {
    return SurveyFoodsByCategoryState(
      result: result ?? this.result,
      completeFood: completeFood ?? this.completeFood,
    );
  }

  @override
  List<Object?> get props => [result, completeFood];
}
