import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/nutrient_info.dart';

class Food extends Equatable {
  final int fdcId;
  final String description;
  final String descriptionPL;
  final String foodClass;
  final Map<String, NutrientInfo> nutrients;

  const Food({
    required this.fdcId,
    required this.description,
    required this.descriptionPL,
    required this.foodClass,
    required this.nutrients,
  });
  @override
  List<Object?> get props => [
    fdcId,
    description,
    descriptionPL,
    foodClass,
    nutrients,
  ];
}
