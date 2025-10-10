import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/data/repository/survey_foods_description_repository.dart';

part 'search_engine_v2_event.dart';
part 'search_engine_v2_state.dart';

class SearchEngineV2Bloc
    extends Bloc<SearchEngineV2Event, SearchEngineV2State> {
  final SurveyFoodsDescriptionRepository repository;

  SearchEngineV2Bloc(this.repository) : super(SearchEngineV2Initial()) {
    on<SearchFoodsByPhrase>(_onSearchFoodsByPhrase);
  }

  Future<void> _onSearchFoodsByPhrase(
    SearchFoodsByPhrase event,
    Emitter<SearchEngineV2State> emit,
  ) async {
    final query = event.phrase.trim();
    if (query.isEmpty) {
      emit(SearchEngineV2LoadSuccess(const DelayedResult.fromValue([])));
      return;
    }

    emit(SearchEngineV2LoadInProgress());

    try {
      final delayed = await repository.getDescription();

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

        emit(SearchEngineV2LoadSuccess(DelayedResult.fromValue(results)));
      } else if (delayed.isError) {
        emit(SearchEngineV2LoadFailure(delayed.error!));
      } else {
        // np. idle (nie powinno się zdarzyć tutaj, ale dla pewności)
        emit(const SearchEngineV2LoadSuccess(DelayedResult.fromValue([])));
      }
    } catch (e, st) {
      emit(SearchEngineV2LoadFailure(Exception('$e\n$st')));
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
