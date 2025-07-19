import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_food_nutrient_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_nutrient_model.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/repository/survey_repository.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/bloc/survey_foods_event.dart';

part 'survey_foods_state.dart';

class SurveyFoodsBloc
    extends Bloc<LoadSurveyFoodsByNutrient, SurveyFoodsState> {
  SurveyFoodsBloc(this.surveyRepository) : super(SurveyFoodsState()) {
    on<LoadSurveyFoodsByNutrient>(_onLoadFoodsByNutrient);
  }

  final SurveyRepository surveyRepository;

  Future<void> _onLoadFoodsByNutrient(
    LoadSurveyFoodsByNutrient event,
    Emitter<SurveyFoodsState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final rawFoods = await surveyRepository.fetchSurveyFoods();

      // final foods = await Isolate.run(
      //   () => surveyRepository.getSortedFoodsByNutrient(event.nutrientNumber),
      // );

      final foods = await Isolate.run(() {
        return sortFoodsByNutrientIsolate(
          SortParams(foods: rawFoods, nutrientNumber: event.nutrientNumber),
        );
      });
      emit(
        state.copyWith(
          nutrientNumber: event.nutrientNumber,
          foods: foods,
          delayedResult: const DelayedResult.fromValue(
            'Survey Foods loaded successfully',
          ),
        ),
      );
      print('Foods Survey loaded successfully');
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}

class SortParams {
  final List<SurveyModel> foods;
  final String nutrientNumber;

  const SortParams({required this.foods, required this.nutrientNumber});
}

List<SurveyModel> sortFoodsByNutrientIsolate(SortParams params) {
  final foods = params.foods;

  foods.sort((a, b) {
    double aAmount =
        a.foodNutrients
            .firstWhere(
              (n) => n.nutrient.number == params.nutrientNumber,
              orElse:
                  () => SurveyFoodNutrientModel(
                    amount: 0.0,
                    nutrient: SurveyNutrientModel(
                      number: '0',
                      name: '',
                      unitName: '',
                    ),
                  ),
            )
            .amount;

    double bAmount =
        b.foodNutrients
            .firstWhere(
              (n) => n.nutrient.number == params.nutrientNumber,
              orElse:
                  () => SurveyFoodNutrientModel(
                    amount: 0.0,
                    nutrient: SurveyNutrientModel(
                      number: '0',
                      name: '',
                      unitName: '',
                    ),
                  ),
            )
            .amount;

    return bAmount.compareTo(aAmount);
  });

  return foods;
}
