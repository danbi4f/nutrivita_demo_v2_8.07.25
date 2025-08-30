import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/shared/repositories/survey_foods_by_category_repository.dart';

part 'survey_foods_by_category_event.dart';
part 'survey_foods_by_category_state.dart';

class SurveyFoodsByCategoryBloc
    extends Bloc<SurveyFoodsByCategoryEvent, SurveyFoodsByCategoryState> {
  final SurveyFoodsByCategoryRepository surveyFoodsByCategoryRepository;

  SurveyFoodsByCategoryBloc(this.surveyFoodsByCategoryRepository)
    : super(const SurveyFoodsByCategoryState()) {
    on<LoadSurveyFoodsByCategory>((event, emit) async {
      emit(state.copyWith(result: const DelayedResult.inProgress()));
      final DelayedResult<List<SurveyFoodsByCategory>> result =
          await surveyFoodsByCategoryRepository.getAllCategories();
      emit(state.copyWith(result: result));
    });
  }
}
