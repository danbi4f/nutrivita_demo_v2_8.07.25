import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/survey_foods_by_category_bloc.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/mod/category_group_v2/category_group_Success_widget_v2.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

class CategoryGroupWidgetV2 extends StatelessWidget {
  const CategoryGroupWidgetV2({super.key});

  static Widget withBloc() {
    return BlocProvider(
      create:
          (context) => SurveyFoodsByCategoryBloc(
            surveyFoodsByCategoryRepository: context.read(),
            completeFoodRepository: context.read(),
          )..add(LoadSurveyFoodsByCategory()),
      child: const CategoryGroupWidgetV2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
      builder: (context, state) {
        final result = state.result;

        if (result.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (result.isError) {
          return Center(child: Text('Błąd: ${result.error}'));
        } else if (result.isSuccessful) {
          final categories = result.valueOrNull ?? [];
          return CategoryGroupSuccessWidgetV2(categories: categories);
        } else {
          return const Center(child: Text('Brak danych'));
        }
      },
    );
  }
}
