import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/repository/survey_repository.dart';
import 'package:nutrivita_demo_v2/survey_foods/data/service/asset_survey_service.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/bloc/survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/bloc/survey_foods_event.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/widget/survey_by_category_success_widget.dart';

class SurveyByCategoryWidget extends StatelessWidget {
  const SurveyByCategoryWidget({super.key, required this.nutrientNumber});

  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SurveyFoodsBloc(SurveyRepository(AssetSurveyService()))
                ..add(LoadSurveyFoodsByNutrient(nutrientNumber)),
      child: BlocBuilder<SurveyFoodsBloc, SurveyFoodsState>(
        builder: (context, state) {
          final result = state.delayedResult;

          if (result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.isSuccessful) {
            return SurveyByCategorySuccessWidget();
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
