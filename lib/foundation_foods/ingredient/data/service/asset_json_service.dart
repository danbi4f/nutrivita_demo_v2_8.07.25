import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/domain/entities/food_entity.dart';
import '../model/final_food.dart';

class AssetJsonService {
  Future<List<FoodEntity>> loadListFinalFood() async {
    final jsonString = await rootBundle.loadString('assets/pl.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return (jsonData['FoundationFoods'] as List)
        .map((map) => FinalFood.fromJson(map))
        .toList();
  }
}
