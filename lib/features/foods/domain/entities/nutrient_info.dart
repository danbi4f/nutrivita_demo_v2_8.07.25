import 'package:equatable/equatable.dart';

class NutrientInfo extends Equatable {
  final String nutrientNumber; // ← unique number from USDA/FoodData Central
  final String nutrientName;
  final String unit;
  final double value; // quantity of ingredient
  final int indexRanking; //position in the ranking

  const NutrientInfo({
    required this.nutrientNumber,
    required this.nutrientName,
    required this.unit,
    required this.value,
    required this.indexRanking,
  });

  @override
  List<Object?> get props => [
        nutrientNumber,
        nutrientName,
        unit,
        value,
        indexRanking,
      ];
}