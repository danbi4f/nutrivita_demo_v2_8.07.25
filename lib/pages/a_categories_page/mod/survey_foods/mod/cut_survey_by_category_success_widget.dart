import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/bloc/cut_survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/mod/cut_survey_by_category_item.dart';

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
          body: CustomContainer(
            isGradient: true,
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
