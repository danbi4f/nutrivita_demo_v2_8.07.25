import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';
import 'package:test/test.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late GetAllCategories usecase;
  late MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    usecase = GetAllCategories(mockCategoryRepository);
  });

  final tCategoryNutrient = CategoryNutrient(category: 'test', nutrients: []);

  test('should get category from the repository', () async {
    // arrange
    when(
      () => mockCategoryRepository.getAllCategories(),
    ).thenAnswer((_) async => Right([tCategoryNutrient]));

    // act
    final result = await usecase(NoParams());

    // assert
        expect(result.isRight(), true); // we check that it is Right
    result.fold(
      (_) => fail('Expected Right, got Left'), // if he were Left
      (data) => expect(data, [tCategoryNutrient]), // we compare the list
    );
  });
}
