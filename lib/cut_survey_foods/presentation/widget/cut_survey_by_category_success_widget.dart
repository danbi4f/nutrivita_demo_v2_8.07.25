import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/bloc/cut_survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/widget/cut_survey_by_category_item.dart';

class CutSurveyByCategorySuccessWidget extends StatelessWidget {
  const CutSurveyByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CutSurveyFoodsBloc, CutSurveyFoodsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
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
        );
      },
    );
  }
}
