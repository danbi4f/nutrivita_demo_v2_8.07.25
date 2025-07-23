import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/model/cut_survey_model.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/repository/cut_survey_repository.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/bloc/cut_survey_foods_event.dart';
part 'cut_survey_foods_state.dart';

class CutSurveyFoodsBloc
    extends Bloc<LoadCutSurveyFoodsByNutrient, CutSurveyFoodsState> {
  CutSurveyFoodsBloc(this.cutSurveyRepository) : super(CutSurveyFoodsState()) {
    on<LoadCutSurveyFoodsByNutrient>(_onLoadFoodsByNutrient);
  }

  final CutSurveyRepository cutSurveyRepository;

  Future<void> _onLoadFoodsByNutrient(
    LoadCutSurveyFoodsByNutrient event,
    Emitter<CutSurveyFoodsState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final List<CutSurveyModel> foods = await cutSurveyRepository
          .getSortedCutSurveyFoodsByNutrient(event.nutrientNumber);
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
