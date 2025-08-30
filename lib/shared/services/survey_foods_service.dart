import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SurveyFoodsService {
  SurveyFoodsService._internal();

  static final SurveyFoodsService _instance = SurveyFoodsService._internal();

  factory SurveyFoodsService() => _instance;

  List<dynamic>? _jsonData;

  /// Ładuje dane z JSON (tylko raz)
  Future<void> _loadData() async {
    if (_jsonData == null) {
      final jsonString = await rootBundle.loadString(
        'assets/cut_survey_foods_pl.json',
      );
      _jsonData = jsonDecode(jsonString) as List<dynamic>;
    }
  }

  /// Pobierz dane w surowym formacie
  Future<List<dynamic>> getRawData() async {
    await _loadData();
    return _jsonData!;
  }
}
