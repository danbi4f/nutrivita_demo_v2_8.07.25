import '../../domain/entities/nutrient_entity.dart';

class NutrientModel extends NutrientEntity {
  NutrientModel({
    required super.number,
    required super.name,
    required super.unitName,
  });
  factory NutrientModel.fromJson(Map<String, dynamic> json) {
    return NutrientModel(
      number: json['number'],
      name: json['name'],
      unitName: json['unitName'],
    );
  }
}
