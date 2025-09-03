import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/survey_foods/bloc/cut_survey_foods_event.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods_repository.dart';
part 'cut_survey_foods_state.dart';

class CutSurveyFoodsBloc
    extends Bloc<LoadCutSurveyFoodsByNutrient, CutSurveyFoodsState> {
  CutSurveyFoodsBloc(this.surveyRepository)
    : super(
        CutSurveyFoodsState().copyWith(
          delayedResult: const DelayedResult.inProgress(),
        ),
      ) {
    on<LoadCutSurveyFoodsByNutrient>(_onLoadFoodsByNutrient);
  }

  final SurveyRepository surveyRepository;

  Future<void> _onLoadFoodsByNutrient(
    LoadCutSurveyFoodsByNutrient event,
    Emitter<CutSurveyFoodsState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final List<SurveyFoods> foods = await surveyRepository
          .getSortedSurveyFoodsByNutrient(event.nutrientNumber);
      emit(
        state.copyWith(
          nutrientNumber: event.nutrientNumber,
          foods: foods,
          delayedResult: const DelayedResult.fromValue(
            'Foods Survey loaded successfully',
          ),
        ),
      );
      print('Foods Survey loaded successfully');
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
