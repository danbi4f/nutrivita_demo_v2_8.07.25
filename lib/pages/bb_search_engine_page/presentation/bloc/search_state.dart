part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<SurveyFoodsDescription> result;
  final DelayedResult<void> loadingResult;
  final bool isFavorite;
  const SearchState({
    required this.result,
    required this.loadingResult,
    required this.isFavorite,
  });

  SearchState copyWith({
    List<SurveyFoodsDescription>? result,
    DelayedResult<void>? loadingResult,
    bool? isFavorite,
  }) {
    return SearchState(
      result: result ?? this.result,
      loadingResult: loadingResult ?? this.loadingResult,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [result, loadingResult, isFavorite];
}
