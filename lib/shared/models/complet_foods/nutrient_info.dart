class NutrientInfo {
  final String nutrientName;
  final String unit;
  final double value; // ilość składnika
  final int indexRanking; // pozycja w rankingu

  NutrientInfo({
    required this.nutrientName,
    required this.unit,
    required this.value,
    required this.indexRanking,
  });
}
