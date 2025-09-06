import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/shared/repositories/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/shared/repositories/survey_foods_by_category_repository.dart';

part 'survey_foods_by_category_event.dart';
part 'survey_foods_by_category_state.dart';

class SurveyFoodsByCategoryBloc
    extends Bloc<SurveyFoodsByCategoryEvent, SurveyFoodsByCategoryState> {
  final SurveyFoodsByCategoryRepository surveyFoodsByCategoryRepository;
  final CompleteFoodRepository completeFoodRepository;

  SurveyFoodsByCategoryBloc({
    required this.surveyFoodsByCategoryRepository,
    required this.completeFoodRepository,
  }) : super(const SurveyFoodsByCategoryState()) {
    on<LoadSurveyFoodsByCategory>(_onLoadSurveyFoodsByCategory);
    on<LoadCompleteFoodByFdcId>(_onLoadCompleteFoodByFdcId);
  }

  Future<void> _onLoadSurveyFoodsByCategory(
    LoadSurveyFoodsByCategory event,
    Emitter<SurveyFoodsByCategoryState> emit,
  ) async {
    emit(state.copyWith(result: const DelayedResult.inProgress()));
    final DelayedResult<List<SurveyFoodsByCategory>> result =
        await surveyFoodsByCategoryRepository.getAllCategories();
    emit(state.copyWith(result: result));
  }

  Future<void> _onLoadCompleteFoodByFdcId(
    LoadCompleteFoodByFdcId event,
    Emitter<SurveyFoodsByCategoryState> emit,
  ) async {
    emit(state.copyWith(result: const DelayedResult.inProgress()));

    final completeFood = await completeFoodRepository.getCompleteFoodByFdcId(
      event.fdcId,
    );
    if (completeFood != null) {
      emit(state.copyWith(completeFood: DelayedResult.fromValue(completeFood)));
      print('complete food fdcid: ${completeFood.fdcId}');
    } else {
      emit(
        state.copyWith(
          completeFood: DelayedResult.fromError(Exception("Food not found")),
        ),
      );
    }
  }
}
