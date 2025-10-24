import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/presentation/bloc/survey_foods_by_category_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

/// Mocki zależności
class MockCombinedDataService extends Mock implements CombinedDataService {}

class MockAppFoodRepository extends Mock implements AppFoodRepository {}

void main() {
  late MockCombinedDataService mockService;
  late MockAppFoodRepository mockRepo;
  late SurveyFoodsByCategoryBloc bloc;

  setUp(() {
    mockService = MockCombinedDataService();
    mockRepo = MockAppFoodRepository();

    when(() => mockService.appFoodRepository).thenReturn(mockRepo);

    bloc = SurveyFoodsByCategoryBloc(combinedDataService: mockService);
  });

  group('SurveyFoodsByCategoryBloc', () {
    final mockCategories = [
      SurveyFoodsByCategory(category: 'Vitamins', nutrients: []),
      SurveyFoodsByCategory(category: 'Minerals', nutrients: []),
    ];

    blocTest<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
      'emituje inProgress i success, gdy repo zwraca dane',
      build: () {
        when(
          () => mockRepo.getAllCategories(),
        ).thenAnswer((_) async => DelayedResult.fromValue(mockCategories));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSurveyFoodsByCategory()),
      expect:
          () => [
            const SurveyFoodsByCategoryState(
              result: DelayedResult.inProgress(),
            ),
            SurveyFoodsByCategoryState(
              result: DelayedResult.fromValue(mockCategories),
            ),
          ],
      verify: (_) => verify(() => mockRepo.getAllCategories()).called(1),
    );

    blocTest<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
      'emituje inProgress i error, gdy repo zwraca wyjątek',
      build: () {
        when(() => mockRepo.getAllCategories()).thenAnswer(
          (_) async => DelayedResult.fromError(Exception('Błąd testowy')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSurveyFoodsByCategory()),
      expect:
          () => [
            const SurveyFoodsByCategoryState(
              result: DelayedResult.inProgress(),
            ),
            isA<SurveyFoodsByCategoryState>()
                .having((s) => s.result.isError, 'result.isError', true)
                .having(
                  (s) => s.result.error.toString(),
                  'error message',
                  contains('Błąd testowy'),
                ),
          ],
      verify: (_) => verify(() => mockRepo.getAllCategories()).called(1),
    );
  });
}
