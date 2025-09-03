import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';

class SearchEngineAssetService {
  Future<List<SurveyFoods>> fetchCutSurveyFoods() async {
    final jsonString = await rootBundle.loadString(
      'assets/cut_survey_foods_pl.json',
    );
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((map) => SurveyFoods.fromJson(map)).toList();
  }
}
