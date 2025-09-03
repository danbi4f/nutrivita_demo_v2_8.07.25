import 'dart:convert';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';

class Meal {
  final int? id; // null przy insert, ustawiane po odczycie z DB
  final String name;
  final List<SurveyFoods> foods;

  Meal({this.id, required this.name, required this.foods});

  // Konwersja do mapy dla SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'foods': jsonEncode(foods.map((x) => x.toMap()).toList()), // JSON string
    };
  }

  // Tworzenie obiektu z mapy odczytanej z SQLite
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      foods:
          (jsonDecode(map['foods']) as List)
              .map((x) => SurveyFoods.fromJson(x))
              .toList(),
    );
  }
}
