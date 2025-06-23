import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/ingredient/domain/entities/food_entity.dart';
import '../models/final_food.dart';

class AssetJsonService {
  Future<List<FoodEntity>> loadListFinalFood() async {
    final jsonString = await rootBundle.loadString(
      'assets/FoodData_Central_foundation_food_json_2025-04-24.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return (jsonData['FoundationFoods'] as List)
        .map((map) => FinalFood.fromJson(map))
        .toList();
  }
}
