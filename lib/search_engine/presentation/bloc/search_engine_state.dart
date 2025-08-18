part of 'search_engine_bloc.dart';

class SearchEngineState extends Equatable {
  const SearchEngineState({
    this.foods = const [],
    this.delayedResult = const DelayedResult.idle(),
    this.searchFoodsByName = '',
  });

  final DelayedResult<String> delayedResult;
  final List<SearchEngineModel> foods;
  final String searchFoodsByName;

  SearchEngineState copyWith({
    List<SearchEngineModel>? foods,
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
