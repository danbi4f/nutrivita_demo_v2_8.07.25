import 'dart:convert';

class SurveyFoods {
  SurveyFoods({
    required this.description,
    required this.foodClass,
    required this.fdcId,
    required this.nutrients,
    required this.nameNutrients,
    required this.unitNameNutrients,
    required this.descriptionPL,
    this.id,
  });

  final int? id; // opcjonalne, bo SQLite autoincrement
  final String description;
  final String descriptionPL;
  final String foodClass;
  final int fdcId;
  final Map<String, double> nutrients;
  final Map<String, String> nameNutrients;
  final Map<String, String> unitNameNutrients;

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
      description: json['description'],
      descriptionPL: json['descriptionPL'],
      foodClass: json['foodClass'],
      fdcId: json['fdcId'],
      nutrients: decodeMap<double>(
        json['nutrients'],
        cast: (v) => (v as num).toDouble(),
      ),
      nameNutrients: decodeMap<String>(
        json['nameNutrients'],
        cast: (v) => v.toString(),
      ),
      unitNameNutrients: decodeMap<String>(
        json['unitNameNutrients'],
        cast: (v) => v.toString(),
      ),
      id: json['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'descriptionPL': descriptionPL,
      'foodClass': foodClass,
      'fdcId': fdcId,
      'nutrients': jsonEncode(nutrients),
      'nameNutrients': jsonEncode(nameNutrients),
      'unitNameNutrients': jsonEncode(unitNameNutrients),
      'id': id,
    };
  }
}
