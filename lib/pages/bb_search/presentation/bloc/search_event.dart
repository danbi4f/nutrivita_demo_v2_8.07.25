part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

final class Search extends SearchEvent {
  final String value;

  const Search(this.value);

  @override
  List<Object?> get props => [value];
}
