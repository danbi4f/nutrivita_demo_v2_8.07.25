class CategoryGroupNutrientNumber {
  CategoryGroupNutrientNumber({
    required this.name,
    required this.number,
    required this.id,
  });

  final String name;
  final String number;
  final int id;

  factory CategoryGroupNutrientNumber.fromJson(Map<String, dynamic> json) {
    return CategoryGroupNutrientNumber(
      name: json['name'],
      number: json['number'],
      id: json['id'],
    );
  }
}
