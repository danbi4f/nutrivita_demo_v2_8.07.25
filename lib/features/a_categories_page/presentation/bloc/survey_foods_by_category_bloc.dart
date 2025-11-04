import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

part 'survey_foods_by_category_event.dart';
part 'survey_foods_by_category_state.dart';

class SurveyFoodsByCategoryBloc
    extends Bloc<SurveyFoodsByCategoryEvent, SurveyFoodsByCategoryState> {
  final CombinedDataService combinedDataService;

  SurveyFoodsByCategoryBloc({required this.combinedDataService})
    : super(const SurveyFoodsByCategoryState()) {
    on<LoadSurveyFoodsByCategory>(_onLoadSurveyFoodsByCategory);
  }

  Future<void> _onLoadSurveyFoodsByCategory(
    LoadSurveyFoodsByCategory event,
    Emitter<SurveyFoodsByCategoryState> emit,
  ) async {
    emit(state.copyWith(result: const DelayedResult.inProgress()));
    final DelayedResult<List<SurveyFoodsByCategory>> result =
        await combinedDataService.appFoodRepository.getAllCategories();


    emit(state.copyWith(result: result));
  }


}
