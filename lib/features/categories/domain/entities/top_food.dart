import 'package:equatable/equatable.dart';

class TopFood extends Equatable {
  final int indexRanking;
  final String rankingName;
  final String description;
  final String descriptionPL;
  final String foodClass;
  final int fdcId;
  final String id;
  final double nutrientValue;
  final String matchedKey;

  const TopFood({
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

  @override
  List<Object?> get props => [
    indexRanking,
    rankingName,
    description,
    descriptionPL,
    foodClass,
    fdcId,
    id,
    nutrientValue,
    matchedKey,
  ];
}
