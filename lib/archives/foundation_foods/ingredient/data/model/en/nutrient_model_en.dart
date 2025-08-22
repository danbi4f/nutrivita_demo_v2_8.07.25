class NutrientModelEN {
  NutrientModelEN({
    required this.number,
    required this.name,
    required this.unitName,
  });

  final String number;
  final String name;
  final String unitName;

  factory NutrientModelEN.fromJson(Map<String, dynamic> json) {
    return NutrientModelEN(
      number: json['number'],
      name: json['name'],
      unitName: json['unitName'],
    );
  }
}
