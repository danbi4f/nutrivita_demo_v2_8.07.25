import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_model.dart';

class AssetSurveyService {
  Future<List<SurveyModel>> fetchSurveyFoods() async {
    final jsonString = await rootBundle.loadString('assets/surveyFoods.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return (jsonData['SurveyFoods'] as List)
        .map((map) => SurveyModel.formJson(map))
        .toList();
  }
}
