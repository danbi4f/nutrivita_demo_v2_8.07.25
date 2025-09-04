import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/shared/repositories/survey_foods_description_repository.dart';

part 'search_engine_v2_event.dart';
part 'search_engine_v2_state.dart';

class SearchEngineV2Bloc
    extends Bloc<SearchEngineV2Event, SearchEngineV2State> {
  final SurveyFoodsDescriptionRepository repository;

  /// Cache całej listy produktów
  List<SurveyFoodsDescription>? _allFoodsCache;

  SearchEngineV2Bloc(this.repository) : super(SearchEngineV2Initial()) {
    on<SearchFoodsByPhrase>(_onSearchFoodsByPhrase);
  }

  Future<void> _onSearchFoodsByPhrase(
    SearchFoodsByPhrase event,
    Emitter<SearchEngineV2State> emit,
  ) async {
    final query = event.phrase.trim();

    if (query.isEmpty) {
      emit(const SearchEngineV2LoadSuccess(DelayedResult.fromValue([])));
      return;
    }

    emit(SearchEngineV2LoadInProgress());

    try {
      // Jeśli cache jest pusty, pobierz dane z repozytorium
      if (_allFoodsCache == null) {
        final delayed = await repository.getDescription();
        if (delayed.isSuccessful) {
          _allFoodsCache = delayed.value!;
        } else if (delayed.isError) {
          emit(SearchEngineV2LoadFailure(delayed.error!));
          return;
        } else {
          emit(const SearchEngineV2LoadSuccess(DelayedResult.fromValue([])));
          return;
        }
      }

      final normalizedQueryWords = _normalize(query).split(' ');

      final seen = <int>{};
      final List<SurveyFoodsDescription> results = [];

      for (final food in _allFoodsCache!) {
        if (normalizedQueryWords.every(
          (word) =>
              _matches(food.normalizedDescription, word) ||
              _matches(food.normalizedDescriptionPL, word),
        )) {
          if (seen.add(food.fdcId)) {
            results.add(food);
          }
        }
      }

      /// 🔎 DEBUG LOGI
      print('[DEBUG BLOC] Query="$query" normalized=$normalizedQueryWords');
      for (var f in results) {
        print('[DEBUG BLOC] Found: ${f.fdcId} -> ${f.descriptionPL}');
      }

      emit(SearchEngineV2LoadSuccess(DelayedResult.fromValue(results)));
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

  /// Dopasowanie całych słów (nie fragmentów)
  bool _matches(String text, String word) {
    return RegExp(r'\b' + RegExp.escape(word) + r'\b').hasMatch(text);
  }
}