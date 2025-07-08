class NutrientGroup {
  NutrientGroup({required this.name, required this.number, required this.id});

  final String name;
  final String number;
  final int id;

  factory NutrientGroup.fromJson(Map<String, dynamic> json) {
    return NutrientGroup(
      name: json['name'],
      number: json['number'],
      id: json['id'],
    );
  }
}
