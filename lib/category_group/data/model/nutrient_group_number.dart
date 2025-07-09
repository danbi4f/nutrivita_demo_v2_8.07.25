class NutrientGroupNumber {
  NutrientGroupNumber({
    required this.name,
    required this.number,
    required this.id,
  });

  final String name;
  final String number;
  final int id;

  factory NutrientGroupNumber.fromJson(Map<String, dynamic> json) {
    return NutrientGroupNumber(
      name: json['name'],
      number: json['number'],
      id: json['id'],
    );
  }
}
