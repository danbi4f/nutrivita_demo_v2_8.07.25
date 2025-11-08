import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_food_by_fdcid.dart';
import 'package:test/test.dart';

class MockFoodRepository extends Mock implements FoodRepository {}
class SomeFailure extends Failure {}

void main() {
  late GetFoodByFdcId usecase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    usecase = GetFoodByFdcId(mockFoodRepository);
  });

  final tFood = Food(
    fdcId: 123,
    description: 'test',
    descriptionPL: 'test',
    foodClass: 'test',
    nutrients: {},
  );

  const tFdcId = 123;

  test('should get a food by fdcId from the repository (Right)', () async {
    //! arrange
    when(() => mockFoodRepository.getFoodById(tFdcId))
        .thenAnswer((_) async => Right(tFood));

    //! act
    final result = await usecase(tFdcId);

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, tFood),
    );

    verify(() => mockFoodRepository.getFoodById(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return Failure if food not found (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    when(() => mockFoodRepository.getFoodById(tFdcId))
        .thenAnswer((_) async => Left(failure));

    //! act
    final result = await usecase(tFdcId);

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFoodRepository.getFoodById(tFdcId)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });
}
