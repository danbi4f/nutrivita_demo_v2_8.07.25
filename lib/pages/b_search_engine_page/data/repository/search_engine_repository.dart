import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/service/search_engine_asset_service.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';

class SearchEngineRepository {
  const SearchEngineRepository(this.searchEngineAssetService);

  final SearchEngineAssetService searchEngineAssetService;

  Future<List<SurveyFoods>> fetchCutSurveyFoods() {
    return searchEngineAssetService.fetchCutSurveyFoods();
  }

  Future<List<SurveyFoods>> searchFoodsByName(String query) async {
    final allFoods = await fetchCutSurveyFoods();

    final normalizedQueryWords = _normalize(query).split(' ');

    return allFoods.where((food) {
      final normalizedDescription = _normalize(food.description);
      final normalizedDescriptionPL = _normalize(food.descriptionPL);

      // Sprawdź, czy chociaż jedno słowo z zapytania występuje w którymkolwiek opisie
      return normalizedQueryWords.every(
        (word) =>
            normalizedDescription.contains(word) ||
            normalizedDescriptionPL.contains(word),
      );
    }).toList();
  }

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

    // 1. Zamień wszystkie znaki na małe litery
    String lower = text.toLowerCase();

    // 2. Zamień polskie znaki na odpowiedniki łacińskie
    String noDiacritics =
        lower.split('').map((char) {
          return polishChars[char] ?? char;
        }).join();

    // 3. Usuń interpunkcję i wielokrotne spacje
    return noDiacritics
        .replaceAll(
          RegExp(r'[^\p{L}\p{N}]+', unicode: true),
          ' ',
        ) // usuwa interpunkcję
        .replaceAll(RegExp(r'\s+'), ' ') // usuwa wielokrotne spacje
        .trim();
  }
}
