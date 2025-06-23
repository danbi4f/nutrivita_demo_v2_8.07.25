class Number {
  Number({required this.name, required this.number});

  String name;
  String number;

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      name: json['name'] as String,
      number: json['number'] as String,
    );
  }
}
