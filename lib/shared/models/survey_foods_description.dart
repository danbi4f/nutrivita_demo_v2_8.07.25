class SurveyFoodsDescription {
  final int fdcId;
  final String description;
  final String descriptionPL;
  final String normalizedDescription;
  final String normalizedDescriptionPL;

  SurveyFoodsDescription({
    required this.fdcId,
    required this.description,
    required this.descriptionPL,
    required this.normalizedDescription,
    required this.normalizedDescriptionPL,
  });

  factory SurveyFoodsDescription.fromJson(Map<String, dynamic> json) {
    return SurveyFoodsDescription(
      fdcId: json['fdcId'] as int,
      description: json['description'] as String? ?? '',
      descriptionPL: json['descriptionPL'] as String? ?? '',
      normalizedDescription: json['normalizedDescription'] as String? ?? '',
      normalizedDescriptionPL: json['normalizedDescriptionPL'] as String? ?? '',
    );
  }
}
