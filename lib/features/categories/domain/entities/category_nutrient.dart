import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';

class CategoryNutrient extends Equatable {
  final String category;
  final List<NutrientNumber> nutrients;

  const CategoryNutrient({required this.category, required this.nutrients});

  @override
  List<Object?> get props => [category, nutrients];
}
