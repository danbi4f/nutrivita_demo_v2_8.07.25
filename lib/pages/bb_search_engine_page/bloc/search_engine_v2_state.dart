part of 'search_engine_v2_bloc.dart';

sealed class SearchEngineV2State extends Equatable {
  const SearchEngineV2State();

  @override
  List<Object?> get props => [];
}

final class SearchEngineV2Initial extends SearchEngineV2State {}

final class SearchEngineV2LoadInProgress extends SearchEngineV2State {}

final class SearchEngineV2LoadSuccess extends SearchEngineV2State {
  final DelayedResult<List<SurveyFoodsDescription>> result;

  const SearchEngineV2LoadSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

final class SearchEngineV2LoadFailure extends SearchEngineV2State {
  final Exception error;

  const SearchEngineV2LoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
