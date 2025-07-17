import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/ingredient/data/model/en/final_food_en.dart';

class AssetJsonServiceEN {
  Future<List<FinalFoodEN>> loadListFinalFoodEN() async {
    final jsonString = await rootBundle.loadString('assets/en.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return (jsonData['FoundationFoods'] as List)
        .map((map) => FinalFoodEN.fromJson(map))
        .toList();
  }
}
