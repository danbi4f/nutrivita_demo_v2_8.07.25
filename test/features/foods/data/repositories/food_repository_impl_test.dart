import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/utils/conversion_service.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/food_model.dart';
import 'package:nutrivita_demo_v2/features/foods/data/repositories/food_repository_impl.dart';

class MockCategoryLocalDataSource extends Mock
    implements CategoryLocalDataSource {}

class MockConversionService extends Mock implements ConversionService {}

void main() {
  late FoodRepositoryImpl repository;
  late MockCategoryLocalDataSource mocklocalDataSource;
  late MockConversionService mockconversionService;

  setUp(() {
    mocklocalDataSource = MockCategoryLocalDataSource();
    mockconversionService = MockConversionService();
    repository = FoodRepositoryImpl(
      localDataSource: mocklocalDataSource,
      conversionService: mockconversionService,
    );
  });

  final tFood = FoodModel(
    fdcId: 1,
    description: 'test',
    descriptionPL: 'test',
    foodClass: 'test',
    nutrients: {},
  );
  final tCategoryNutrientModel = CategoryNutrientModel(
    category: 'test',
    nutrients: [],
  );

  group('getAllFoods()', () {
    test(
      'should return Right(List<Food>) when datasource returns categories and convert to Food model',
      () async {
        //! arrange
        when(
          () => mocklocalDataSource.getCategories(),
        ).thenAnswer((_) async => [tCategoryNutrientModel]);
        when(
          () => mockconversionService.fromCategory([tCategoryNutrientModel]),
        ).thenAnswer((_) => [tFood]);
        //! act
        final result = await repository.getAllFoods();
        //! assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right, got Left'),
          (data) => expect(data, [tFood]),
        );
        verify(() => mocklocalDataSource.getCategories()).called(1);
        verifyNoMoreInteractions(mocklocalDataSource);
      },
    );
    test(
      'should return Right([]) when datasource returns empty categories',
      () async {
        //! arrange
        when(
          () => mocklocalDataSource.getCategories(),
        ).thenAnswer((_) async => []);
        when(() => mockconversionService.fromCategory([])).thenReturn([]);

        //! act
        final result = await repository.getAllFoods();

        //! assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right, got Left'),
          (data) => expect(data, []),
        );
        verify(() => mocklocalDataSource.getCategories()).called(1);
        verifyNoMoreInteractions(mocklocalDataSource);
      },
    );
    test(
      'should return Left(CacheFailure) when datasource throws exception',
      () async {
        //! arrange
        when(
          () => mocklocalDataSource.getCategories(),
        ).thenThrow(Exception());

        //! act
        final result = await repository.getAllFoods();

        //! assert
        expect(result.isLeft(), true);
      },
    );
  });

  group('getFoodsByFdcIds()', () {
    test(
      'should return Right(filtered foods) when ids exist in cached list',
      () async {
        //! arrange
        when(
          () => mocklocalDataSource.getCategories(),
        ).thenAnswer((_) async => [tCategoryNutrientModel]);
        when(
          () => mockconversionService.fromCategory([tCategoryNutrientModel]),
        ).thenReturn([tFood]);

        //! act
        await repository.getAllFoods();
        final result = await repository.getFoodsByFdcIds([1]);

        //! assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right, got Left'),
          (data) => expect(data, [tFood]),
        );
      },
    );

    test('should return Right([]) when none of ids match', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryNutrientModel]);
      when(
        () => mockconversionService.fromCategory([tCategoryNutrientModel]),
      ).thenReturn([tFood]);

      //! act
      await repository.getAllFoods();
      final result = await repository.getFoodsByFdcIds([99]);

      //! assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right, got Left'),
        (data) => expect(data, []),
      );
    });

    test(
      'should return Left(CacheFailure) when underlying getAllFoods throws',
      () async {
        //! arrange
        when(
          () => mocklocalDataSource.getCategories(),
        ).thenThrow(Exception('boom'));

        //! act
        final result = await repository.getFoodsByFdcIds([1]);

        //! assert
        expect(result.isLeft(), true);
      },
    );
  });

  group('getFoodById()', () {
    test('should return Right(Food) when found', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryNutrientModel]);
      when(
        () => mockconversionService.fromCategory([tCategoryNutrientModel]),
      ).thenReturn([tFood]);

      //! act
      await repository.getAllFoods();
      final result = await repository.getFoodById(1);

      //! assert
      expect(result.isRight(), true);
    });

    test('should return Left(FoodNotFoundFailure) when not found', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryNutrientModel]);
      when(
        () => mockconversionService.fromCategory([tCategoryNutrientModel]),
      ).thenReturn([tFood]);

      //! act
      await repository.getAllFoods();
      final result = await repository.getFoodById(99);

      //! assert
      expect(result.isLeft(), true);
    });

    test('should return Left(CacheFailure) when getAllFoods throws', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenThrow(Exception());

      //! act
      final result = await repository.getFoodById(1);

      //! assert
      expect(result.isLeft(), true);
    });
  });

  group('searchFoods()', () {
    test('should return Right(all foods) when query is empty', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryNutrientModel]);
      when(
        () => mockconversionService.fromCategory([tCategoryNutrientModel]),
      ).thenReturn([tFood]);

      //! act
      await repository.getAllFoods();
      final result = await repository.searchFoods('');

      //! assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right, got Left'),
        (data) => expect(data, [tFood]),
      );
    });

    test('should return Right(filtered foods) when query matches', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryNutrientModel]);
      when(
        () => mockconversionService.fromCategory([tCategoryNutrientModel]),
      ).thenReturn([tFood]);

      //! act
      await repository.getAllFoods();
      final result = await repository.searchFoods('tes');

      //! assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right, got Left'),
        (data) => expect(data, [tFood]),
      );
    });

    test('should return Left(CacheFailure) when getAllFoods throws', () async {
      //! arrange
      when(
        () => mocklocalDataSource.getCategories(),
      ).thenThrow(Exception());

      //! act
      final result = await repository.searchFoods('test');

      //! assert
      expect(result.isLeft(), true);
    });
  });
}
