part of 'search_engine_v2_bloc.dart';

sealed class SearchEngineV2Event extends Equatable {
  const SearchEngineV2Event();

  @override
  List<Object?> get props => [];
}

final class SearchFoodsByPhrase extends SearchEngineV2Event {
  final String phrase;

  const SearchFoodsByPhrase(this.phrase);

  @override
  List<Object?> get props => [phrase];
}
