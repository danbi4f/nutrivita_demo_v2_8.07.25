import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/repository/cut_survey_repository.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/service/cut_survey_asset_service.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/bloc/cut_survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/bloc/cut_survey_foods_event.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/widget/cut_survey_by_category_success_widget.dart';

class CutSurveyByCategoryWidget extends StatelessWidget {
  const CutSurveyByCategoryWidget({super.key, required this.nutrientNumber});

  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CutSurveyFoodsBloc(CutSurveyRepository(CutSurveyAssetService()))
                ..add(LoadCutSurveyFoodsByNutrient(nutrientNumber)),
      child: BlocBuilder<CutSurveyFoodsBloc, CutSurveyFoodsState>(
        builder: (context, state) {
          final result = state.delayedResult;

          if (result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.isSuccessful) {
            return CutSurveyByCategorySuccessWidget();
          } else if (result.isError) {
            return Center(child: Text('Error: //${state.delayedResult.error}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
