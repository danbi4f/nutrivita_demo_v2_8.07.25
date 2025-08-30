class TopFood {
  final int indexRanking;
  final String rankingName;
  final String description;
  final String descriptionPL;
  final String foodClass;
  final int fdcId;
  final String id;
  final double nutrientValue;
  final String matchedKey;

  TopFood({
    required this.indexRanking,
    required this.rankingName,
    required this.description,
    required this.descriptionPL,
    required this.foodClass,
    required this.fdcId,
    required this.id,
    required this.nutrientValue,
    required this.matchedKey,
  });

  factory TopFood.fromJson(Map<String, dynamic> json) {
    return TopFood(
      indexRanking: json['indexRanking'] ?? 0,
      rankingName: json['rankingName'] ?? '',
      description: json['description'] ?? '',
      descriptionPL: json['descriptionPL'] ?? '',
      foodClass: json['foodClass'] ?? '',
      fdcId: json['fdcId'] ?? 0,
      id: json['id'] ?? '',
      nutrientValue: (json['nutrientValue'] ?? 0).toDouble(),
      matchedKey: json['matchedKey'] ?? '',
    );
  }
}
