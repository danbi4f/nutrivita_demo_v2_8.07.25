import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_all_foods.dart';
import 'package:test/test.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

class SomeFailure extends Failure {}

void main() {
  late GetAllFoods usecase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    usecase = GetAllFoods(mockFoodRepository);
  });

  final tFood = Food(
    fdcId: 123,
    description: 'test',
    descriptionPL: 'test',
    foodClass: 'test',
    nutrients: {},
  );

  test('should get all foods from the repository (Right)', () async {
    //! arrange
    when(
      () => mockFoodRepository.getAllFoods(),
    ).thenAnswer((_) async => Right([tFood]));

    //! act
    final result = await usecase(NoParams());

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, [tFood]),
    );

    verify(() => mockFoodRepository.getAllFoods()).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return empty list if no foods (Right)', () async {
    //! arrange
    when(
      () => mockFoodRepository.getAllFoods(),
    ).thenAnswer((_) async => Right([]));

    //! act
    final result = await usecase(NoParams());

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, isEmpty),
    );

    verify(() => mockFoodRepository.getAllFoods()).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return Failure (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    when(
      () => mockFoodRepository.getAllFoods(),
    ).thenAnswer((_) async => Left(failure));

    //! act
    final result = await usecase(NoParams());

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFoodRepository.getAllFoods()).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });
}
