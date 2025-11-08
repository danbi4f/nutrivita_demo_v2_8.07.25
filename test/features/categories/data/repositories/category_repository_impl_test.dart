import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/error/exceptions.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';
import 'package:nutrivita_demo_v2/features/categories/data/repositories/category_repository_impl.dart';

class MockCategoryLocalDataSource extends Mock
    implements CategoryLocalDataSource {}


void main() {
  late CategoryRepositoryImpl repository;
  late MockCategoryLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCategoryLocalDataSource();
    repository = CategoryRepositoryImpl(
      categoryLocalDataSource: mockLocalDataSource,
    );
  });

  final tCategoryNutrientModel = CategoryNutrientModel(category: 'test', nutrients: []);

  test('should return Right(list) when datasource returns categories', () async {
    //! arrange
    when(() => mockLocalDataSource.getCategories())
        .thenAnswer((_) async => [tCategoryNutrientModel]);

    //! act
    final  result = await repository.getAllCategories(); //Future<Either<Failure, List<CategoryNutrient>>> getAllCategories()
   //Either<Failure, List<CategoryNutrient>>
    //! assert
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected Right, got Left'),
      (data) => expect(data, [tCategoryNutrientModel]),
    );

    verify(() => mockLocalDataSource.getCategories()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('should return Left() when datasource throws CacheException',
      () async {
    //! arrange
    when(() => mockLocalDataSource.getCategories())
        .thenThrow(CacheException());

    //! act
    final result = await repository.getAllCategories();

    //! assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<CacheFailure>()),
      (_) => fail('Expected Left, got Right'),
    );

    verify(() => mockLocalDataSource.getCategories()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
