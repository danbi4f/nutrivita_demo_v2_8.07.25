import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:nutrivita_demo_v2/number/data/model/number.dart';

class AssetNumberService {
  Future<List<Number>> loadListNumbers() async {
    final jsonString = await rootBundle.loadString(
      'assets/nutrient_number.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return (jsonData['numbers'] as List)
        .map((json) => Number.fromJson(json))
        .toList();
  }
}
