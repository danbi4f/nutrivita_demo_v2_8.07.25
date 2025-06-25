import 'package:equatable/equatable.dart';

class Number extends Equatable {
  const Number({required this.name, required this.number});

  final String name;
  final String number;

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      name: json['name'] as String,
      number: json['number'] as String,
    );
  }

  const Number.empty() : name = '', number = '';

  @override
  List<Object> get props => [name, number];
}
