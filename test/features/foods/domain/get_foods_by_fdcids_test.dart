import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/usecases/get_foods_by_fdcids.dart';
import 'package:test/test.dart';

class MockFoodRepository extends Mock implements FoodRepository {}
class SomeFailure extends Failure {}

void main() {
  late GetFoodsByFdcids usecase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    usecase = GetFoodsByFdcids(mockFoodRepository);
  });

  final tFood1 = Food(
    fdcId: 123,
    description: 'test1',
    descriptionPL: 'test1',
    foodClass: 'test',
    nutrients: {},
  );

  final tFood2 = Food(
    fdcId: 456,
    description: 'test2',
    descriptionPL: 'test2',
    foodClass: 'test',
    nutrients: {},
  );

  final tFdcIds = [123, 456];

  test('should get foods by fdcIds from the repository (Right)', () async {
    //! arrange
    when(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds))
        .thenAnswer((_) async => Right([tFood1, tFood2]));

    //! act
    final result = await usecase(FdcIdsParams(fdcIds: tFdcIds));

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, [tFood1, tFood2]),
    );

    verify(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return empty list if no foods (Right)', () async {
    //! arrange
    when(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds))
        .thenAnswer((_) async => Right([]));

    //! act
    final result = await usecase(FdcIdsParams(fdcIds: tFdcIds));

    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, isEmpty),
    );

    verify(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });

  test('should return Failure (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    when(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds))
        .thenAnswer((_) async => Left(failure));

    //! act
    final result = await usecase(FdcIdsParams(fdcIds: tFdcIds));

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockFoodRepository.getFoodsByFdcIds(tFdcIds)).called(1);
    verifyNoMoreInteractions(mockFoodRepository);
  });
}
