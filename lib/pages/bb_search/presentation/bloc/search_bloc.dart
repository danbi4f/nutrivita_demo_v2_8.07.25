import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CombinedDataService combinedDataService;

  SearchBloc({required this.combinedDataService})
    : super(
        SearchState(
          result: [],
          loadingResult: DelayedResult.idle(),
          isFavorite: false,
        ),
      ) {
    on<Search>(_onSearch);
  }

  Future<void> _onSearch(Search event, Emitter<SearchState> emit) async {
    emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
    final query = event.value.trim();
    if (query.isEmpty) {
      return;
    }

    try {
      final delayed =
          await combinedDataService.appSearchEngineRepository.getDescription();

      if (delayed.isSuccessful) {
        final allFoods = delayed.value!;
        final normalizedQueryWords = _normalize(query).split(' ');

        final seen = <int>{};
        final List<SurveyFoodsDescription> results = [];

        for (final food in allFoods) {
          if (normalizedQueryWords.every(
            (word) =>
                food.normalizedDescription.contains(word) ||
                food.normalizedDescriptionPL.contains(word),
          )) {
            if (seen.add(food.fdcId)) {
              results.add(food);
            }
          }
        }
        emit(SearchState(
          result: results,
          loadingResult: DelayedResult.fromValue(results),
          isFavorite:  isFavorite,
        ));
      } else if (delayed.isError) {
        emit(SearchState(
          result: [],
          loadingResult:
              DelayedResult.fromError(Exception('Failed to load data')),
          isFavorite: false,
        ));
      } else {
        // np. idle (nie powinno się zdarzyć tutaj, ale dla pewności)
        emit(SearchState(
          result: [],
          loadingResult: DelayedResult.idle(),
          isFavorite: false,
        ));
      }
    } catch (e) {
      emit(SearchState(
        result: [],
        loadingResult: DelayedResult.fromError(Exception(e.toString())),
        isFavorite: false,
      ));
    }
  }

  /// Minimalna normalizacja frazy wprowadzonej przez użytkownika
  String _normalize(String text) {
    const polishChars = {
      'ą': 'a',
      'ć': 'c',
      'ę': 'e',
      'ł': 'l',
      'ń': 'n',
      'ó': 'o',
      'ś': 's',
      'ż': 'z',
      'ź': 'z',
    };

    String lower = text.toLowerCase();
    String noDiacritics =
        lower.split('').map((char) => polishChars[char] ?? char).join();
    return noDiacritics
        .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
