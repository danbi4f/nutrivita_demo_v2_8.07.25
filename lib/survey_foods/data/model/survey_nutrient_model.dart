class SurveyNutrientModel {
  const SurveyNutrientModel({
    required this.number,
    required this.name,
    required this.unitName,
  });

  final String number;
  final String name;
  final String unitName;

  factory SurveyNutrientModel.fromJson(Map<String, dynamic> json) {
    return SurveyNutrientModel(
      number: json['number'],
      name: json['name'],
      unitName: json['unitName'],
    );
  }
}
