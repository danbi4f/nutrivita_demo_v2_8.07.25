part of 'search_engine_bloc.dart';

class SearchEngineState extends Equatable {
  const SearchEngineState({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
    this.searchFoodsByName = '',
  });

  final DelayedResult<String> delayedResult;
  final List<SurveyFoods> foods;
  final String searchFoodsByName;

  SearchEngineState copyWith({
    List<SurveyFoods>? foods,
    DelayedResult<String>? delayedResult,
    String? searchFoodsByName,
  }) {
    return SearchEngineState(
      searchFoodsByName: searchFoodsByName ?? this.searchFoodsByName,

      foods: foods ?? this.foods,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object?> get props => [foods, delayedResult, searchFoodsByName];
}
