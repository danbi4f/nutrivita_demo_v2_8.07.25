import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/bloc/survey_foods_bloc.dart';
import 'package:nutrivita_demo_v2/survey_foods/presentation/widget/survey_by_category_item.dart';

class SurveyByCategorySuccessWidget extends StatelessWidget {
  const SurveyByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyFoodsBloc, SurveyFoodsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: state.foods.length,
            itemBuilder: (context, index) {
              final item = state.foods[index];
              final nutrientNumber = state.nutrientNumber;
              return SurveyByCategoryItem(
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
