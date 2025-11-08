import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/search_foods.dart';
import 'package:test/test.dart';

class MockFoodRepository extends Mock implements FoodRepository {}
class SomeFailure extends Failure {}

void main() {
  late SearchFoodsUseCase usecase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    usecase = SearchFoodsUseCase(mockFoodRepository);
  });

  final tQuery = 'apple';
  final tFood1 = Food(
    fdcId: 123,
    description: 'Apple',
    descriptionPL: 'Jabłko',
    foodClass: 'fruit',
    nutrients: {},
  );
  final tFood2 = Food(
    fdcId: 456,
    description: 'Green Apple',
    descriptionPL: 'Zielone jabłko',
    foodClass: 'fruit',
    nutrients: {},
  );

  test('should return list of foods matching the query (Right)', () async {
    //! arrange
    when(() => mockFoodRepository.searchFoods(tQuery))
        .thenAnswer((_) async => Right([tFood1, tFood2]));

    //! act
    final result = await usecase(tQuery);

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, [tFood1, tFood2]),
    );

    verify(() => mockFoodRepository.searchFoods(tQuery)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return empty list if no foods match (Right)', () async {
    //! arrange
    when(() => mockFoodRepository.searchFoods(tQuery))
        .thenAnswer((_) async => Right([]));

    //! act
    final result = await usecase(tQuery);

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, isEmpty),
    );

    verify(() => mockFoodRepository.searchFoods(tQuery)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return Failure (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    when(() => mockFoodRepository.searchFoods(tQuery))
        .thenAnswer((_) async => Left(failure));

    //! act
    final result = await usecase(tQuery);

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFoodRepository.searchFoods(tQuery)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });
}
