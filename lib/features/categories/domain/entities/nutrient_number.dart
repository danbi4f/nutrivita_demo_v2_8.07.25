import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/top_food.dart';

class NutrientNumber extends Equatable {
  final int nutrientId;
  final String nutrientNumber;
  final String nutrientName;
  final String unit;
  final List<TopFood> topFoods;

  const NutrientNumber({
    required this.nutrientId,
    required this.nutrientNumber,
    required this.nutrientName,
    required this.unit,
    required this.topFoods,
  });

  @override
  List<Object?> get props => [
    nutrientId,
    nutrientNumber,
    nutrientName,
    unit,
    topFoods,
  ];
}
