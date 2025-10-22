import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrivita_demo_v2/pages/bb_search/domain/model/survey_foods_description.dart';

class SurveyFoodsDescriptionService {
  SurveyFoodsDescriptionService._internal();

  static final SurveyFoodsDescriptionService _instance =
      SurveyFoodsDescriptionService._internal();

  factory SurveyFoodsDescriptionService() => _instance;

  List<SurveyFoodsDescription>? _description;

  /// Ładuje dane z JSON (tylko raz)
  Future<void> _loadData() async {
    if (_description == null) {
      final jsonString = await rootBundle.loadString(
        'assets/v2/sorted_SF_by_category_desc_nolimit/foods_extracted_description.json',
      );
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      _description =
          jsonData
              .map((item) => SurveyFoodsDescription.fromJson(item))
              .toList();
    }
  }

  /// Pobierz dane w surowym formacie
  Future<List<SurveyFoodsDescription>> getDescription() async {
    await _loadData();
    return _description!;
  }
}
