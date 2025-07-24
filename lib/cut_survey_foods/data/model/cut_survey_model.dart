class CutSurveyModel {
  CutSurveyModel({
    required this.description,
    required this.foodClass,
    required this.fdcId,
    required this.nutrients,
    required this.nameNutrients,
    required this.unitNameNutrients,
    required this.descriptionPL,
  });

  final String description;
  final String descriptionPL;
  final String foodClass;
  final int fdcId;
  final Map<String, double> nutrients;
  final Map<String, String> nameNutrients;
  final Map<String, String> unitNameNutrients;

  factory CutSurveyModel.fromJson(Map<String, dynamic> json) {
    return CutSurveyModel(
      description: json['description'],
      descriptionPL: json['descriptionPL'],
      foodClass: json['foodClass'],
      fdcId: json['fdcId'],
      nutrients: Map<String, double>.from((json['nutrients'] ?? {}) as Map),
      nameNutrients: Map<String, String>.from(
        (json['nameNutrient'] ?? {}) as Map,
      ),
      unitNameNutrients: Map<String, String>.from(
        (json['unitNameNutrient'] ?? {}) as Map,
      ),
    );
  }
}
