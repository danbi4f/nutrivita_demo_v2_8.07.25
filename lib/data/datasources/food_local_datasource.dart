import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/food_model.dart';

class FoodLocalDataSource {
  Future<List<FoodModel>> loadFoods() async {
    final jsonStr = await rootBundle.loadString(
      'assets/FoodData_Central_foundation_food_json_2025-04-24.json',
    );
    final jsonMap = jsonDecode(jsonStr);
    return (jsonMap['FoundationFoods'] as List)
        .map((e) => FoodModel.fromJson(e))
        .toList();
  }
}