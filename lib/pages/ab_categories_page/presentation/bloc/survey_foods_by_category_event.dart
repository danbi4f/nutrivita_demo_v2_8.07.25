part of 'survey_foods_by_category_bloc.dart';

sealed class SurveyFoodsByCategoryEvent extends Equatable {
  const SurveyFoodsByCategoryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSurveyFoodsByCategory extends SurveyFoodsByCategoryEvent {}

final class LoadCompleteFoodByFdcId extends SurveyFoodsByCategoryEvent {
  const LoadCompleteFoodByFdcId(this.fdcId);

  final int fdcId;
}
