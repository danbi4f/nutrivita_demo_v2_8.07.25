class CutSurveyModel {
  CutSurveyModel({
    required this.description,
    required this.foodClass,
    required this.fdcId,
    required this.nutrients,
  });

  final String description;
  final String foodClass;
  final int fdcId;
  final Map<String, double> nutrients;

  factory CutSurveyModel.fromJson(Map<String, dynamic> json) {
    return CutSurveyModel(
      description: json['description'],
      foodClass: json['foodClass'],
      fdcId: json['fdcId'],
      nutrients: Map<String, double>.from((json['nutrients'] ?? {}) as Map),
    );
  }
}
