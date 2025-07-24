import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/model/cut_survey_model.dart';

class CutSurveyAssetService {
  Future<List<CutSurveyModel>> fetchCutSurveyFoods() async {
    final jsonString = await rootBundle.loadString(
      'assets/cut_survey_foods_pl.json',
    );
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((map) => CutSurveyModel.fromJson(map)).toList();
  }
}
