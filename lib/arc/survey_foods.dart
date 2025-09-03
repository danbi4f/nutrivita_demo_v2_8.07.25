import 'dart:convert';

class SurveyFoods {
  final int? id;
  final String description;
  final String descriptionPL;
  final String foodClass;
  final int fdcId;
  final Map<String, double> nutrients;
  final Map<String, String> nameNutrient;
  final Map<String, String> unitNameNutrient;
  final int? indexRanking;
  final String? rankingName;

  SurveyFoods({
    required this.description,
    required this.foodClass,
    required this.fdcId,
    required this.nutrients,
    required this.nameNutrient,
    required this.unitNameNutrient,
    required this.descriptionPL,
    this.id,
    this.indexRanking,
    this.rankingName,
  });

  factory SurveyFoods.fromJson(Map<String, dynamic> json) {
    // funkcja pomocnicza do dekodowania map
    Map<String, T> decodeMap<T>(dynamic input, {T Function(dynamic)? cast}) {
      if (input == null) return {};
      if (input is String) {
        return Map<String, dynamic>.from(
          jsonDecode(input),
        ).map((k, v) => MapEntry(k, cast != null ? cast(v) : v as T));
      } else if (input is Map) {
        return Map<String, dynamic>.from(
          input,
        ).map((k, v) => MapEntry(k, cast != null ? cast(v) : v as T));
      } else {
        return {};
      }
    }

    return SurveyFoods(
      indexRanking: json['indexRanking'],
      rankingName: json['rankingName'],
      description: json['description'],
      descriptionPL: json['descriptionPL'],
      foodClass: json['foodClass'],
      fdcId: json['fdcId'],
      nutrients: decodeMap<double>(
        json['nutrients'],
        cast: (v) => (v as num).toDouble(),
      ),
      nameNutrient: decodeMap<String>(
        json['nameNutrient'],
        cast: (v) => v.toString(),
      ),
      unitNameNutrient: decodeMap<String>(
        json['unitNameNutrient'],
        cast: (v) => v.toString(),
      ),
      id: json['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'indexRanking': indexRanking,
      'rankingName': rankingName,
      'description': description,
      'descriptionPL': descriptionPL,
      'foodClass': foodClass,
      'fdcId': fdcId,
      'nutrients': jsonEncode(nutrients),
      'nameNutrient': jsonEncode(nameNutrient),
      'unitNameNutrient': jsonEncode(unitNameNutrient),
      'id': id,
    };
  }

  SurveyFoods copyWith({
    int? id,
    String? description,
    String? descriptionPL,
    String? foodClass,
    int? fdcId,
    Map<String, double>? nutrients,
    Map<String, String>? nameNutrient,
    Map<String, String>? unitNameNutrient,
    int? indexRanking,
    String? rankingName,
  }) {
    return SurveyFoods(
      id: id ?? this.id,
      description: description ?? this.description,
      descriptionPL: descriptionPL ?? this.descriptionPL,
      foodClass: foodClass ?? this.foodClass,
      fdcId: fdcId ?? this.fdcId,
      nutrients: nutrients ?? this.nutrients,
      nameNutrient: nameNutrient ?? this.nameNutrient,
      unitNameNutrient: unitNameNutrient ?? this.unitNameNutrient,
      indexRanking: indexRanking ?? this.indexRanking,
      rankingName: rankingName ?? this.rankingName,
    );
  }
}
