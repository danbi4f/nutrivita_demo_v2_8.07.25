class NutrientInfo {
  final String nutrientNumber; // ← unikalny numer z USDA/FoodData Central
  final String nutrientName;
  final String unit;
  final double value; // ilość składnika
  final int indexRanking; // pozycja w rankingu

  NutrientInfo({
    required this.nutrientNumber,
    required this.nutrientName,
    required this.unit,
    required this.value,
    required this.indexRanking,
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

  factory NutrientInfo.fromMap(Map<String, dynamic> map) {
    return NutrientInfo(
      nutrientNumber: map['nutrientNumber'],
      nutrientName: map['nutrientName'],
      unit: map['unit'],
      value: (map['value'] as num).toDouble(),
      indexRanking: map['indexRanking'],
    );
  }
}
