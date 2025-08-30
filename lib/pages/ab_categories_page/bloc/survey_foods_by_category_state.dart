part of 'survey_foods_by_category_bloc.dart';

class SurveyFoodsByCategoryState extends Equatable {
  final DelayedResult<List<SurveyFoodsByCategory>> result;

  const SurveyFoodsByCategoryState({this.result = const DelayedResult.idle()});

  SurveyFoodsByCategoryState copyWith({
    DelayedResult<List<SurveyFoodsByCategory>>? result,
  }) {
    return SurveyFoodsByCategoryState(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}
