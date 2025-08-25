import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/bloc/cut_survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/bloc/cut_survey_foods_event.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/mod/cut_survey_by_category_success_widget.dart';
import 'package:nutrivita_demo_v2/shared/survey_foods_2/repository/survey_foods_repository_2.dart';
import 'package:nutrivita_demo_v2/shared/survey_foods_2/services/survey_foods_service_2/survey_foods_service_2.dart';

class CutSurveyByCategoryWidget extends StatelessWidget {
  final String nutrientNumber;
  final VoidCallback onBack; // callback do powrotu do SelectNumber

  const CutSurveyByCategoryWidget({
    super.key,
    required this.nutrientNumber,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBack, // powrót do SelectNumber
            ),
            title: Text(
              "Survey Foods",
              style: AppTextStyles.heading(context, size: 40),
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: BlocProvider(
            create:
                (context) =>
                    CutSurveyFoodsBloc(SurveyRepository2(SurveyFoodsService2()))
                      ..add(LoadCutSurveyFoodsByNutrient(nutrientNumber)),
            child: BlocBuilder<CutSurveyFoodsBloc, CutSurveyFoodsState>(
              builder: (context, state) {
                final result = state.delayedResult;

                if (result.isInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (result.isSuccessful) {
                  return CutSurveyByCategorySuccessWidget();
                } else if (result.isError) {
                  return Center(
                    child: Text('Error: //${state.delayedResult.error}'),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
