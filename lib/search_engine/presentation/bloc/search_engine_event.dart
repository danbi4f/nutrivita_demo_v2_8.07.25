part of 'search_engine_bloc.dart';

sealed class SearchEngineEvent extends Equatable {
  const SearchEngineEvent();

  @override
  List<Object> get props => [];
}

class LoadCutSurveyFoodsByName extends SearchEngineEvent {
  const LoadCutSurveyFoodsByName(this.searchFoodsByName);

  final String searchFoodsByName;

  @override
  List<Object> get props => [searchFoodsByName];
}

class ClearSearchResults extends SearchEngineEvent {}
