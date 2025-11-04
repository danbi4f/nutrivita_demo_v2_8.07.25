// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/survey_foods_by_category_bloc.dart';
// import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
// import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
// import 'package:nutrivita_demo_v2/features/categories/data/repositories/category_repository_impl.dart';
// import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';

// /// Dependency mocks
// class MockCombinedDataService extends Mock implements CombinedDataService {}

// class MockAppFoodRepository extends Mock implements AppFoodRepository {}

// void main() {
//   late MockCombinedDataService mockService;
//   late MockAppFoodRepository mockRepo;
//   late SurveyFoodsByCategoryBloc bloc;

//   setUp(() {
//     mockService = MockCombinedDataService();
//     mockRepo = MockAppFoodRepository();

//     when(() => mockService.appFoodRepository).thenReturn(mockRepo);

//     bloc = SurveyFoodsByCategoryBloc(combinedDataService: mockService);
//   });

//   group('SurveyFoodsByCategoryBloc', () {
//     final mockCategories = [
//       CategoryNutrient(category: 'Vitamins', nutrients: []),
//       CategoryNutrient(category: 'Minerals', nutrients: []),
//     ];

//     blocTest<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
//       'emits inProgress and success when the repo returns data',
//       build: () {
//         when(
//           () => mockRepo.getAllCategories(),
//         ).thenAnswer((_) async => DelayedResult.fromValue(mockCategories));
//         return bloc;
//       },
//       act: (bloc) => bloc.add(LoadSurveyFoodsByCategory()),
//       expect:
//           () => [
//             const SurveyFoodsByCategoryState(
//               result: DelayedResult.inProgress(),
//             ),
//             SurveyFoodsByCategoryState(
//               result: DelayedResult.fromValue(mockCategories),
//             ),
//           ],
//       verify: (_) => verify(() => mockRepo.getAllCategories()).called(1),
//     );

//     blocTest<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
//       'emits inProgress and error when repo returns an exception',
//       build: () {
//         when(() => mockRepo.getAllCategories()).thenAnswer(
//           (_) async => DelayedResult.fromError(Exception('Błąd testowy')),
//         );
//         return bloc;
//       },
//       act: (bloc) => bloc.add(LoadSurveyFoodsByCategory()),
//       expect:
//           () => [
//             const SurveyFoodsByCategoryState(
//               result: DelayedResult.inProgress(),
//             ),
//             isA<SurveyFoodsByCategoryState>()
//                 .having((s) => s.result.isError, 'result.isError', true)
//                 .having(
//                   (s) => s.result.error.toString(),
//                   'error message',
//                   contains('Test error'),
//                 ),
//           ],
//       verify: (_) => verify(() => mockRepo.getAllCategories()).called(1),
//     );
//   });
// }
