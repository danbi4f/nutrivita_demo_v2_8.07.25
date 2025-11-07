import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/food_model.dart';
import 'package:nutrivita_demo_v2/core/utils/conversion_service.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class FoodRepositoryImpl extends FoodRepository {
  FoodRepositoryImpl({
    required this.localDataSource,
    required this.conversionService,
  });

  final CategoryLocalDataSource localDataSource;
  final ConversionService conversionService;
  List<FoodModel>? _cachedFoods;


  @override
Future<Either<Failure, List<FoodModel>>> getAllFoods() async {
  try {
    if (_cachedFoods != null) return Right(_cachedFoods!);

    final categories = await localDataSource.getCategories();
    _cachedFoods = conversionService.fromCategory(categories);

    return Right(_cachedFoods!);
  } catch (e) {
    return Left(CacheFailure()); 
  }
}


  @override
Future<Either<Failure, List<FoodModel>>> getFoodsByFdcIds(List<int> fdcIds) async {
  try {
    final result = await getAllFoods();
    return result.fold(
      (failure) => Left(failure),
      (foods) {
        final fdcSet = fdcIds.toSet();
        final filtered = foods.where((f) => fdcSet.contains(f.fdcId)).toList();
        return Right(filtered);
      },
    );
  } catch (_) {
    return Left(CacheFailure());
  }
}



@override
Future<Either<Failure, FoodModel>> getFoodById(int fdcId) async {
  try {
    final result = await getAllFoods();
    return result.fold(
      (failure) => Left(failure),
      (foods) {
        final food = foods.firstWhereOrNull((f) => f.fdcId == fdcId);
        if (food == null) return Left(FoodNotFoundFailure());
        return Right(food);
      },
    );
  } catch (_) {
    return Left(CacheFailure());
  }
}



  @override
Future<Either<Failure, List<FoodModel>>> searchFoods(String query) async {
  try {
    final result = await getAllFoods();
    return result.fold(
      (failure) => Left(failure),
      (foods) async {
        if (query.isEmpty) return Right(foods);
        final filtered = await compute(
          _search,
          {'query': query, 'foods': foods},
        );
        return Right(filtered);
      },
    );
  } catch (_) {
    return Left(CacheFailure());
  }
}

  // ============================================================
  // 🔹 FUNCTION RUNNING IN ISOLATE
  // ============================================================
  static List<FoodModel> _search(Map<String, dynamic> data) {
    final String query = data['query'] as String;
    final List<FoodModel> foods = List<FoodModel>.from(data['foods']);

    final normalizedQuery = _normalize(query);

    final filtered =
        foods.where((food) {
          final name = _normalize(food.description);
          final namePL = _normalize(food.descriptionPL);

          if (name.contains(normalizedQuery) ||
              namePL.contains(normalizedQuery)) {
            return true;
          }

          final nameDistance = _levenshteinDistance(name, normalizedQuery);
          final namePLDistance = _levenshteinDistance(namePL, normalizedQuery);

          return nameDistance <= 2 || namePLDistance <= 2;
        }).toList();

    return filtered;
  }

  // ============================================================
  // 🔹 LEVENSHTEIN'S ALGORITHM
  // ============================================================
  static int _levenshteinDistance(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final matrix = List.generate(
      b.length + 1,
      (i) => List<int>.generate(a.length + 1, (j) => j),
    );

    for (int i = 1; i <= b.length; i++) {
      matrix[i][0] = i;
    }

    for (int i = 1; i <= b.length; i++) {
      for (int j = 1; j <= a.length; j++) {
        final substitutionCost = a[j - 1] == b[i - 1] ? 0 : 1;
        matrix[i][j] = _min3(
          matrix[i - 1][j] + 1, // removal
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + substitutionCost, // exchange
        );
      }
    }

    return matrix[b.length][a.length];
  }

  static int _min3(int a, int b, int c) =>
      (a < b) ? (a < c ? a : c) : (b < c ? b : c);

  static String _normalize(String text) {
    const polishChars = {
      'ą': 'a',
      'ć': 'c',
      'ę': 'e',
      'ł': 'l',
      'ń': 'n',
      'ó': 'o',
      'ś': 's',
      'ż': 'z',
      'ź': 'z',
    };

    final lower = text.toLowerCase();
    final noDiacritics =
        lower.split('').map((char) => polishChars[char] ?? char).join();

    return noDiacritics
        .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
