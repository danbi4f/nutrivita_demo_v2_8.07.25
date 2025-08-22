import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/archives/cut_survey_foods/presentation/bloc/cut_survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/archives/cut_survey_foods/presentation/widget/cut_survey_by_category_item.dart';

class CutSurveyByCategorySuccessWidget extends StatelessWidget {
  const CutSurveyByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CutSurveyFoodsBloc, CutSurveyFoodsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            title: Text(
              'List of Survey Foods',
              style: AppTextStyles.heading(context),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),

                  Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  blurRadius: 20,
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final item = state.foods[index];
                final nutrientNumber = state.nutrientNumber;
                return CutSurveyByCategoryItem(
                  item: item,
                  nutrientNumber: nutrientNumber,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
