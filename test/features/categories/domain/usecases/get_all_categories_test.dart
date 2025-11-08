import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';
import 'package:test/test.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

class SomeFailure extends Failure {}

void main() {
  late GetAllCategories usecase;
  late MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    usecase = GetAllCategories(mockCategoryRepository);
  });

  final tCategoryNutrient = CategoryNutrient(category: 'test', nutrients: []);

  test('should get category from the repository (Right)', () async {
    //=========================================================================
    //! arrange
    when(
      () => mockCategoryRepository.getAllCategories(),
    ).thenAnswer((_) async => Right([tCategoryNutrient]));

    //=========================================================================
    //! act
    final result = await usecase(NoParams());

    //=========================================================================
    //! assert

    //--------------------------------------------------------------------
    expect(result.isRight(), true); // we check that it is Right
    result.fold(
      (_) => fail('Expected Right, got Left'), // if he were Left
      (data) => expect(data, [tCategoryNutrient]), // we compare the list
    );
    //--------------------------------------------------------------------
    verify(() => mockCategoryRepository.getAllCategories()).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);

    //=========================================================================
  });

  test('should return empty list (Right)', () async {
    //! arrange
    when(
      () => mockCategoryRepository.getAllCategories(),
    ).thenAnswer((_) async => Right([]));
    //! act
    final result = await usecase(NoParams());
    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, isEmpty),
    );

    verify(() => mockCategoryRepository.getAllCategories()).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });

  test('should return Failure (Left)', () async {
    //! arrange
    final failure = SomeFailure();
    //! act
    when(
      () => mockCategoryRepository.getAllCategories(),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase(NoParams());
    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f, failure),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockCategoryRepository.getAllCategories()).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}
