import 'package:nutrivita_demo_v2/features/foods/domain/entities/nutrient_info.dart';

class NutrientInfoModel extends NutrientInfo {


  const NutrientInfoModel({
    required super.nutrientNumber,
    required super.nutrientName,
    required super.unit,
    required super.value,
    required super.indexRanking,
  });

  Map<String, dynamic> toMap() {
    return {
      'nutrientNumber': nutrientNumber,
      'nutrientName': nutrientName,
      'unit': unit,
      'value': value,
      'indexRanking': indexRanking,
    };
  }

  factory NutrientInfoModel.fromMap(Map<String, dynamic> map) {
    return NutrientInfoModel(
      nutrientNumber: map['nutrientNumber'],
      nutrientName: map['nutrientName'],
      unit: map['unit'],
      value: (map['value'] as num).toDouble(),
      indexRanking: map['indexRanking'],
    );
  }
}
